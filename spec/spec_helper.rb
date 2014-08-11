require 'pg'
require 'rspec'
require './lib/lines'
require './lib/station'
require './lib/stops'
require 'pry'

DB = PG.connect(:dbname => 'train_station_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
  end
end
