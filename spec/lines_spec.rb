require 'spec_helper'

describe 'Line' do
  it 'creates a new line' do
    test_line = Line.new({:name => "Main Line"})
    expect(test_line).to be_an Line
  end

  it 'returns the name of the line' do
    test_line = Line.new({:name => "Main Line"})
    expect(test_line.name).to eq "Main Line"
  end

  describe "save" do
    it 'allows you to save a line' do
      test_line = Line.new({:name => "Main Line"})
      test_line.save
      results = DB.exec("SELECT * FROM lines")
      expect(test_line.id).to be_an Integer
    end
  end

  describe "self.all" do
    it "returns all lines from database" do
      test_line = Line.new({:name => "Main Line"})
      test_line.save
      expect(Line.all.length).to eq 1
    end
  end

  describe "delete" do
    it "allows the user to delete a line" do
      test_line = Line.new({:name => "First Line"})
      test_line.save
      Line.delete(test_line.id)
      expect(Line.all.length).to eq 0
    end
  end

  describe "change_name" do
    it 'alters the name of a line' do
      test_line = Line.new({:name => "First Line"})
      test_line.save
      Line.change_name(test_line.id, "second line")
      expect(Line.all[0].name).to eq "second line"
    end
  end
end
