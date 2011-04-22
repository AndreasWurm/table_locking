module ActiveRecord
  module TableLocking
    # = Active Record Locking
    # This module enables table locking
    # http://www.postgresql.org/docs/9.0/static/explicit-locking.html
    module ClassMethods
      def lock_table(lock_mode = 'SHARE')
        connection.lock_table(table_name, lock_mode)
      end
    end
  end

  module ConnectionAdapters
    module DatabaseStatements
      def lock_table(table_name, lock_mode)
        valid_modes = ['ACCESS SHARE', 'ROW SHARE', 'ROW EXCLUSIVE', 'SHARE UPDATE EXCLUSIVE',
                     'SHARE', 'SHARE ROW EXCLUSIVE', 'EXCLUSIVE', 'ACCESS EXCLUSIVE']

        lock_mode = lock_mode.to_str.upcase.gsub('_',' ')

        raise ArgumentError.new "invalid lock mode #{lock_mode.inspect}" unless valid_modes.include? lock_mode
        raise ArgumentError.new "not in a transaction" if open_transactions == 0

        execute "LOCK #{table_name} IN #{lock_mode} MODE"
      end
    end
  end

  Base.class_eval do
    extend TableLocking::ClassMethods
  end
end