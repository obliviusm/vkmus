module Coercion
  ARRAY_SEP = '/';
  class << self
    def coerce_for_csv list, types_hash
      list.map do |item|
        types_hash.each do |name, type|
          item[name] = coerce_item_for_csv item[name], type
        end
        item
      end
    end

    def coerce_item_for_csv val, type
      val = if type == "arr"
        # p val
        val.join(ARRAY_SEP)
      else
        val.to_s
      end
      val.tr(';','').tr(',','').tr('&', 'and')
    end

    def coerce list, types_hash
      list.map do |item|
        types_hash.each do |name, type|
          item[name] = coerce_item item[name], type
        end
        item
      end
    end

    def coerce_item val, type
      case type
      when "int"
        val.to_i
      when "str"
        val.to_s
      when "arr"
        var.split(ARRAY_SEP)
      else
        val
      end
    end
  end
end
