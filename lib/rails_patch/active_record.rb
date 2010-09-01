module ActiveRecord
  class Base
    def self.find_boolean(find_type, field, value=true)
      self.find(find_type,
                :conditions => ["#{field} = ?", value])
    end
  end
end

