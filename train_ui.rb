require 'pg'
require './lib/lines'
require './lib/stops'
require './lib/station'
require 'pry'

DB = PG.connect({:dbname => 'train_station'})

def welcome
  system("clear")
  puts "Welcome to Train Station Manager"
  loop do
    puts "[l]ines | [s]tations | s[t]ops | [q]uery | e[x]it"
    main_choice = gets.chomp
    if main_choice == "l"
      puts "Press 'lc' to create a line"
      puts "Press 'le' to edit a line"
      puts "Press 'ld' to delete a line"
      second_choice = gets.chomp
    elsif main_choice == "s"
      puts "Press 'sc' to create a station"
      puts "Press 'se' to edit a station"
      puts "Press 'sd' to delete a station"
      second_choice = gets.chomp
    elsif main_choice == "t"
      puts "Press 'tc' to create a stop"
      puts "Press 'te' to edit a stop"
      puts "Press 'td' to delete a stop"
      second_choice = gets.chomp
    elsif main_choice == "x"
      exit
    elsif main_choice == "q"
      puts "Press 'ql' to show all lines"
      puts "Press 'qs' to show all stations"
      puts "Press 'qls' to show all stations for a line"
      puts "Press 'qsl' to show all lines for a station"
      second_choice = gets.chomp
    else
      "Not a valid option, try again"
      welcome
    end
    if second_choice == 'lc'
      create_line
    elsif second_choice == 'le'
      edit_line
    elsif second_choice == 'ld'
      delete_line
    elsif second_choice == 'sc'
      create_station
    elsif second_choice == 'se'
      edit_station
    elsif second_choice == 'sd'
      delete_station
    elsif second_choice == 'tc'
      create_stop
    elsif second_choice == 'te'
      edit_stop
    elsif second_choice == 'td'
      delete_stop
    elsif second_choice == 'ql'
      query_lines
    elsif second_choice == 'qs'
      query_stations
    elsif second_choice == 'qls'
      query_line_stations
    elsif second_choice == 'qsl'
      query_station_lines
    else
      "Not a valid option, try again"
      welcome
    end
  end
end

def create_line
  puts "Enter line name"
  line_name = gets.chomp
  new_line = Line.new({:name => line_name})
  new_line.save
end

def edit_line
  Line.display_lines
  puts "Enter id of line you want to change"
  user_id = gets.chomp
  puts "Enter new line name"
  user_name = gets.chomp
  Line.change_name(user_id, user_name)
end

def delete_line
  Line.display_lines
  puts "Enter id of line"
  user_line_id = gets.chomp
  Line.delete_line(user_line_id)
end

def create_station
  puts "Enter station name"
  station_name = gets.chomp
  new_station = Station.new({:name => station_name})
  new_station.save
end

def edit_station
  Station.display_stations
  puts "Enter id of station you want to change"
  user_id = gets.chomp
  puts "Enter new station name"
  user_name = gets.chomp
  Station.change_name(user_id, user_name)
end

def delete_station
  Station.display_stations
  puts "Enter id of station"
  user_station_id = gets.chomp
  Station.delete_station(user_station_id)
end

def create_stop
  Line.display_lines
  puts "Enter id of line"
  user_line_id = gets.chomp
  Station.display_stations
  puts "Enter id of station"
  user_station_id = gets.chomp
  new_stop = Stop.new({:line_id => user_line_id, :station_id => user_station_id})
  new_stop.save
end

def edit_stop
  Stop.display_stops
  puts "enter the id of the stop you would like to edit"
  user_id = gets.chomp
  puts "enter new line id"
  user_line_id = gets.chomp
  puts "enter new station id"
  user_station_id = gets.chomp
  Stop.edit(user_id, user_line_id, user_station_id)
end

def delete_stop
  Stop.display_stops
  puts "Enter id of stop"
  user_stop_id = gets.chomp
  Stop.delete_stop(user_stop_id)
end

def query_lines
  Line.display_lines
end

def query_stations
  Station.display_stations
end

def query_line_stations
  Line.display_lines
  puts "Enter the id of the line you would like to view stops for"
  user_line = gets.chomp
  results = DB.exec("SELECT stations.name FROM stations
                    JOIN stops ON (stops.station_id = stations.id)
                    JOIN lines ON (stops.line_id = lines.id)
                    WHERE lines.id = #{user_line};")
  results.each do |item|
    puts "#{item['name']}"
  end
end

def query_station_lines
  Station.display_stations
  puts "Enter the id of the station you would like to view lines for"
  user_station = gets.chomp
  results = DB.exec("SELECT lines.name FROM lines
                    JOIN stops ON (stops.line_id = lines.id)
                    JOIN stations ON (stops.station_id = stations.id)
                    WHERE stations.id = #{user_station};")
  results.each do |item|
    puts "#{item['name']}"
  end
end

welcome

