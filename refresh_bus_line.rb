class RefreshBusLine < Filter
  include Communication
  include ValidationInput::Choice
  def initialize
    @data_base = WorkWithDb.new
    @new_table = CreateTerminalTable.new
    super
  end

  def refresh_line(column)
    @data_of_buses = @data_base.info_from_db('buses', 'non-profit')
    @new_table.tr_table('Non-profit buses routs list', column, @data_of_buses)
    multi_hash_of_row = make_hash_id_to_row(@data_of_buses)
    user_choice = invalid_user_choice?('Please enter the ID of bus line that you want to refresh')
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      row[:departure_time] = (DateTime.parse(row[:departure_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')
      row[:arrival_time] = (DateTime.parse(row[:arrival_time]) + Rational('1')).strftime('%d.%m.%Y %H:%M')
      @new_table.tr_table("Refreshed schedule of bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize}", row.keys, [row.values])
      user_confir = confirmation('Refresh the schedule of this bus line? Please enter Yes/No')
      @data_base.refresh('buses', user_choice, row[:departure_time], row[:arrival_time], row[:number_of_seats]) if user_confir == 'yes'
      puts 'Bus line was was refreshed!'
    end
  end
end
