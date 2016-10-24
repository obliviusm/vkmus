module Filterer
  class << self
    def by list, name, value
      list.keep_if do |item|
        item[name].include? value
      end
    end
  end
end
