# frozen_string_literal: true

require 'bundler/inline'

class ParlamentScraper < Kimurai::Base
  @name = 'parlament_spider'
  @engine = :mechanize
  @start_urls = ['http://www.cdep.ro/pls/parlam/structura2015.de?idl=1']
  @config = {
    encoding: 'ISO-8859-2'
  }

  def parse(response, url:, data: {})
    @base_uri = 'http://www.cdep.ro'
    response = browser.current_response

    response.css('div.grup-parlamentar-list table tbody tr').first(8).last(2).each do |line|
      href = line.css('td')[1].css('a').attr('href')
      browser.visit(@base_uri + href)
      app_response = browser.current_response
      scraped_parlament_apps(app_response)
    end
  end

  private

  def scraped_parlament_apps(response)
    item = {
      speaking_count: 0,
      legislative_initiative_count: 0,
      draft_decision_count: 0,
      question_count: 0,
      motion_signed_count: 0
    }

    item[:name] = response&.css('div.boxTitle h1')&.text&.squish
    item[:picture_url] = @base_uri + response&.css('div.profile-pic-dep a img')&.attr('src')&.text&.squish
    item[:email] = response&.css('span.mailInfo')&.text&.squish
    item[:party] = response&.css('div.boxDep')[1]&.css('table tr td')&.text&.squish
    # periods = response&.css('div.profile-dep h3')&.text&.squish.split.last.split("-")
    # item[:legislature] = {
    #   start_date: periods[0],
    #   end_date: periods[1]
    # }
    item[:electoral_circumscription] = response&.css('div.boxDep')[0]&.text&.squish&.split[6]&.split(".").last

    addresses(response&.css('div.boxDep')[-1], item)
    parties(response&.css('div.boxDep')[2]&.css('table'), item)

    deputy_legislature = StoreDeputyInfo.new(item).call

    activity(response&.css('div.boxDep')[-2]&.css('table'), item)

    StoreDeputyActivity.new(data: item, deputy_legislature: deputy_legislature).call
    # save_to "result_nou.json", item, format: :pretty_json, position: false
  end

  def parties(table, item)
    array = []
    table&.css('tr').each do |line|
      name = line&.css('td')[0]&.text&.squish&.split("Grupul parlamentar ").last
      name = name[3..] if name[..2] == 'al '
      name = acronym(name)
      start_date = '2020-12-20'
      end_date = nil

      text = line&.css('td')&.last&.text&.squish
      case text
      when /din/
        start_date = format_date(text)
      when /până în/
        end_date = format_date(text)
      end

      array << {
        party: name,
        start_date: start_date,
        end_date: end_date
      }
    end
    item[:parties] = array
  end

  def addresses(box, item)
    array = []
    list = box&.css('ol li')
    unless list.empty?
      list.map { |li| array << li&.text&.squish }
    else
      box&.css('p').map do |p|
        p&.text&.split("\n").map { |address| array << address.squish[3..] }
      end
    end
    item[:addresses] = array
  end

  def activity(table, item)
    table&.css('tr').each do |line|
      value = line&.css('td')[1]&.text&.squish
      href = line&.css('td')[1]&.css('a')&.attr('href')
      if href
        browser.visit(@base_uri + href)
        response = browser.current_response
      end
      array = []

      case line&.css('td')[0]&.text&.squish
      when 'Luari de cuvânt:'
        item[:speaking_count] = value
        last_date = nil
        response&.css('div.grup-parlamentar-list table tbody tr').each do |li|
          val = unless li&.css('td table.innertable tbody tr td b').empty?
                  li&.css('td table.innertable tbody tr td')[0]&.text&.squish
                else
                  nil
                end
          if val
            last_date = date(val)
          else
            icon_src = li&.css('td a img')&.attr('src')&.text&.squish
            array << {
              title: {
                first: li&.css('td')&.text&.squish
              },
              date: last_date
            } if icon_src == '/img/icon_go2.gif'
            array[-1][:title][:second] = li&.css('td')&.text&.squish if array[-1] && icon_src == '/img/icon_go1.gif'
          end
        end
        item[:speakings] = array
      when 'Propuneri legislative iniţiate:'
        item[:legislative_initiative_count] = value
        response&.css('div.grup-parlamentar-list table tbody tr').each do |li|
          val = li&.css('td')[1]&.text&.squish&.split('/')
          array << {
            title: li&.css('td')[3]&.text&.squish,
            number: val[0]&.squish,
            date: parse_date(val[1]&.squish)
          }
        end
        item[:legislative_initiatives] = array
      when 'Proiecte de hotarâre iniţiate:'
        item[:draft_decision_count] = value
        response&.css('div.grup-parlamentar-list table tbody tr').each do |li|
          val = li&.css('td')[1]&.text&.squish&.split('/')
          array << {
            title: li&.css('td')[2]&.text&.squish,
            number: val[0]&.squish,
            date: val[1]&.squish
          }
        end
        item[:draft_decisions] = array
      when 'Întrebari şi interpelări:'
        item[:question_count] = value
        response&.css('div.grup-parlamentar-list table tbody tr').each do |li|
          val = li&.css('td')[1]&.text&.squish&.split('/')
          i = val[1].index(' ')
          kind_number = val[0]&.squish.split
          array << {
            title: val[1][i+1..]&.squish,
            kind: kind_number[0],
            number: kind_number[1],
            date: parse_date(val[1][...i]&.squish)
          }
        end
        item[:questions] = array
      when 'Moţiuni:'
        item[:motion_signed_count] = value
        response&.css('table.video-table tbody tr').each do |li|
          val = li&.css('td')[3]&.text&.squish&.split('/')
          array << {
            title: li&.css('td')[1]&.text&.squish,
            number: val[0]&.squish,
            date: parse_date(val[1]&.squish),
            status: li&.css('td')[4]&.text&.squish&.downcase
          }
        end
        item[:motions_signed] = array
      end
    end
  end

  def parse_date(date)
    Date.parse(date).iso8601 if date
  end

  def date(text)
    h = {
      ianuarie: 1,
      februarie: 2,
      martie: 3,
      aprilie: 4,
      mai: 5,
      iunie: 6,
      iulie: 7,
      august: 8,
      septembrie: 9,
      octombrie: 10,
      noiembrie: 11,
      decembrie: 12
    }
    text = text.split.last(3)
    text[1] = h[text[1].to_sym]
    parse_date(text.join('-'))
  end

  def format_date(text)
    h = {
      ian: 1,
      feb: 2,
      mar: 3,
      apr: 4,
      mai: 5,
      iun: 6,
      iul: 7,
      aug: 8,
      sep: 9,
      oct: 10,
      noi: 11,
      dec: 12
    }
    text = text.split.last(2)
    text.unshift(1)
    text[1] = h[text[1][..2].to_sym]
    parse_date(text.join('-'))
  end

  def acronym(name)
    case name.downcase
      when /social democrat/
        name = 'PSD'
      when /naţional liberal/
        name = 'PNL'
      when /salvaţi românia/
        name = 'USR'
      when /AUR/
        name = 'AUR'
      when /democrate maghiare din românia/
        name = 'UDMR'
      when /minorităţi/
        name = 'MIN'
      when /neafiliaţi/
        name = 'NA'
    end
    name
  end
end

# ParlamentAppsScraper.crawl!
