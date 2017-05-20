
class CreateTerminalTable
  def tr_table(title, column, row_in_db)
    table = Terminal::Table.new title: title, headings: column, rows: row_in_db
    puts table
  end
end
