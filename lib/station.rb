class Station

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    all_stations = []
    results = DB.exec("SELECT * FROM stations")
    results.each do |result|
      all_stations << Station.new({:name => result['name'],:id => result['id']})
    end
    all_stations
  end

  def self.delete(id)
    DB.exec("DELETE FROM stations WHERE id = #{id};")
  end

  def self.change_name(id, new_name)
    DB.exec("UPDATE stations SET name = '#{new_name}' WHERE id = #{id};")
  end

  def self.display_stations
    all_stations = Station.all
    all_stations.each do |station|
      puts "#{station.id}. #{station.name}"
    end
    all_stations
  end
end
