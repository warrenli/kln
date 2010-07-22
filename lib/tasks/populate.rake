namespace :db do
  desc "Fill the database with test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    Order.populate 50 do |order|
      order.customer = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      order.currency = ['AUD','EUR','HKD','USD']
      order.price    = [10.99, 30.77, 50.66, 70.33, 99.11]
      order.delivered   = [true, false]
      order.expiration_date  = ['2011-01-01','2011-04-04','2010-07-07','2010-10-10']
    end

    Task.populate 50 do |task|
      task.description = "#{Faker::Lorem.sentence(2)}"
      task.priority    = ["High", "Moderate", "Low", "Remote"]
      task.due_on      = ["2011-01-01 00:00:00", "2011-05-01 05:05:05", "2011-09-09 09:09:09"]
    end
  end
end

