class LoadFiles
  class << self
    def config
      unless @files
        puts 'Loading files...'
        require 'sqlite3'
        require 'date'
        require 'terminal-table'
        require_relative 'user.rb'
        require_relative 'describe_opportunities.rb'
        require_relative 'admin.rb'
        require_relative 'customer.rb'
        require_relative 'work_with_db.rb'
        require_relative 'create_terminal_table.rb'
        require_relative 'show_terminal_table.rb'
        require_relative 'new_line.rb'
        require_relative 'refresh_bus_line.rb'
        require_relative 'delete_bus_line.rb'
        require_relative 'buy_tickets.rb'
        @files ||= self
      end
    end
  end
end
