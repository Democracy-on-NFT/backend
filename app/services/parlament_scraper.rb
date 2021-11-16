# frozen_string_literal: true

require 'bundler/inline'

# ParlamentAppsScraper
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

    response.css('div.grup-parlamentar-list table tbody tr').first(1).each do |line|
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
    activity(response&.css('div.boxDep')[-2]&.css('table'), item)

    save_to 'result_nou.json', item, format: :pretty_json, position: false
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
          val = li&.css('td table.innertable tbody tr td')[0]&.text&.squish
          if val
            last_date = parse_date(date(val))
          else
            icon_src = li&.css('td a img')&.attr('src')&.text&.squish
            if icon_src == '/img/icon_go2.gif'
              array << {
                title: {
                  first: li&.css('td')&.text&.squish
                },
                date: last_date
              }
            end
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
          array << {
            title: val[1][i + 1..]&.squish,
            number: val[0]&.squish,
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
            date: parse_date(val[1]&.squish)
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
    text.join('-')
  end
end

# ParlamentAppsScraper.crawl!
