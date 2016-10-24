module Common
  class << self
    def to_filename obj
      obj = obj.join("-") if obj.is_a? Array
      obj.downcase.underscore
    end
  end
end
