require 'spec_helper'

describe 'Stop' do
  it 'creates a stop which takes an agrument of a line and station' do
    test_line = Line.new({:name => "Main Line"})
    test_line.save
    test_station = Station.new({:name => "First Station"})
    test_station.save
    test_stop = Stop.new({:line_id => test_line.id, :station_id => test_station.id})
    expect(test_stop).to be_an Stop
  end

  it 'returns the station and line id' do
    test_line = Line.new({:name => "Main Line"})
    test_line.save
    test_station = Station.new({:name => "First Station"})
    test_station.save
    test_stop = Stop.new({:line_id => test_line.id, :station_id => test_station.id})
    expect(test_stop.line_id).to be_an Integer
  end

  describe 'save' do
    it 'saves a stop to the database' do
      test_line = Line.new({:name => "Main Line"})
      test_line.save
      test_station = Station.new({:name => "First Station"})
      test_station.save
      test_stop = Stop.new({:line_id => test_line.id, :station_id => test_station.id})
      test_stop.save
      results = DB.exec("SELECT * FROM stations")
      expect(test_stop.id).to be_an Integer
    end
  end

  describe "self.all" do
    it "returns all stops from database" do
      test_stop = Stop.new({:line_id => 3, :station_id => 4})
      test_stop.save
      expect(Stop.all.length).to eq 1
    end
  end

  describe 'edit' do
    it 'changes the line or station id of a stop' do
      test_line = Line.new({:name => "Main Line"})
      test_line.save
      test_station = Station.new({:name => "First Station"})
      test_station.save
      test_stop = Stop.new({:line_id => test_line.id, :station_id => test_station.id})
      test_stop.save
      Stop.edit(test_stop.id, 12, 34)
      expect(Stop.all.first.line_id.to_i).to eq 12
    end
  end

  describe 'delete' do
    it 'deletes a stop from the database' do
      test_stop = Stop.new({:line_id => 4, :station_id => 6})
      test_stop.save
      Stop.delete(test_stop.id)
      expect(Stop.all.length).to eq 0
    end
  end


end
