class Stop

  attr_accessor :line_id, :station_id, :id

  def initialize(attributes)
    @line_id = attributes[:line_id]
    @station_id = attributes[:station_id]
    @id = attributes[:id]

  end

  def save
    results = DB.exec("INSERT INTO stops (line_id, station_id) VALUES ('#{@line_id}','#{@station_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.edit(id, new_line_id, new_station_id)

    DB.exec("UPDATE stops SET line_id = #{new_line_id} WHERE id = #{id};")
    DB.exec("UPDATE stops SET station_id = #{new_station_id} WHERE id = #{id};")
  end

  def self.all
    all_stops = []
    results = DB.exec("SELECT * FROM stops")
    results.each do |result|
      all_stops << Stop.new({:line_id => result['line_id'],:id => result['id'], :station_id => result['station_id']})
    end
    all_stops
  end

  def self.delete(id)
    DB.exec("DELETE FROM stops WHERE id = #{id};")
  end

  def self.display_stops
    all_stops = Stop.all
    all_stops.each do |stop|
      puts "id: #{stop.id}. line id: #{stop.line_id} station id: #{stop.station_id}"
    end

  end
end
