module Filterer
  class << self
    def by list, name, value
      list.keep_if do |item|
        # p (value - item[name])
        !item[name].empty? && (value - item[name]).empty?
      end
    end
  end
end
