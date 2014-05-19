namespace :db do
  desc "Runs rake db:drop db:create db:migrate to recreate a valid schema.rb"
  task restart: :environment do
    ['drop', 'create', 'migrate'].each do |task|
      Rake::Task['db:'+task].execute
    end
  end
end
