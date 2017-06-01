class DeleteBusLine < Filter
  include Communication
  include ValidationInput::Choice
  def initialize
    @data_base = WorkWithDb.new
    @new_table = CreateTerminalTable.new
    super
  end

  def delete_line(column)
    @data_of_buses = @data_base.info_from_db('buses', 'non-profit')
    @new_table.tr_table('Non-profit buses routs list', column, @data_of_buses)
    multi_hash_of_row = make_hash_id_to_row(@data_of_buses)
    user_choice = invalid_user_choice?('Please enter the ID of bus line that you want to delete')
    multi_hash_of_row.each_pair do |key, row|
      next unless key == user_choice.to_i
      @new_table.tr_table("Bus line - ID #{row[:id]}: #{row[:departure_city].capitalize} - #{row[:arrival_city].capitalize} - will be deleted!", row.keys, [row.values])
      user_confir = confirmation('Delete this bus line? Please enter Yes/No')
      @data_base.delete('buses', user_choice) if user_confir == 'yes'
      puts 'Bus line was deleted!'
    end
  end
end
