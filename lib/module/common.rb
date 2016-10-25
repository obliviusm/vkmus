module Common
  class << self
    def to_filename obj
      # p obj
      obj = obj.join("-") if obj.is_a? Array
      obj = obj.underscore
      # p obj
      obj
    end

    def modify_filpath filepath
      filepath.split("/").tap do |filepath_arr|
        yield filepath_arr
      end.join("/")
    end
  end
end
