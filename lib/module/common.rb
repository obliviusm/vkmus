module Common
  class << self
    def to_filename obj
      # p obj
      obj = obj.join("-") if obj.is_a? Array
      obj = obj.underscore
      # p obj
      obj
    end
  end
end
