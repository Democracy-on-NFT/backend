namespace :parlament do
  desc 'Data migrations after deployment'
  task migrate: :environment do
    Rake::Task['parlament:template'].invoke
    Rake::Task['parlament:scrapper'].invoke
    Rake::Task['parlament:bigchaindb'].invoke
  end

  desc 'Data migration template task'
  task template: :environment do
    # All tasks should be idempotent
    puts 'Template tasks - test purposes!'
  end

  desc 'Scrapp parlament data'
  task scrapper: :environment do
    pp 'Before the scrapper'
    ParlamentScraper.crawl!
    pp 'After the scrapper'
  end

  desc 'Push activities to BDB'
  task bigchaindb: :environment do
    pp 'Before the bigchaindb call'
    PushActivitiesToBdb.new.call
    pp 'After the bigchaindb call'
  end
end
