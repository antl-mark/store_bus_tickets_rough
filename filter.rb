class Filter
  def initialize
    @array_row = []
    @multi_dimensional_hash_of_row = {}
    @array_of_key = %i[id departure_city arrival_city departure_time arrival_time number_of_seats available_seats]
  end

  def make_hash_id_to_row(array_row)
    array_row.each_with_index do |row, _i|
      @array_row << Hash[@array_of_key.zip(row)]
    end
    @array_row.each do |elem|
      @multi_dimensional_hash_of_row[elem[:id]] = elem
    end
    @multi_dimensional_hash_of_row
  end
end
