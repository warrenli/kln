namespace :db do
  desc "Fill the database with test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    Order.populate 100 do |order|
      order.customer = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
      order.currency = ['AUD','EUR','HKD','USD']
      order.price    = [10.99, 30.77, 50.66, 70.33, 99.11]
      order.delivered   = [true, false]
      order.expiration_date  = ['2011-01-01','2011-04-04','2010-07-07','2010-10-10']
    end
  end
end

