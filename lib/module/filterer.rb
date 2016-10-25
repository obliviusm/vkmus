module Filterer
  class << self
    def by list, name, value
      list.select do |item|
        # p (value - item[name])
        if item[name].is_a? String
          # binding.pry
          # item[name] == value
          value.include? item[name]
        else
          !item[name].empty? && (value - item[name]).empty?
        end
      end
    end
  end
end
