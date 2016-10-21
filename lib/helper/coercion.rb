module Coercion
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
    else
      val
    end
  end
end
