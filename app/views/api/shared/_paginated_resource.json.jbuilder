items ||= nil
count ||= nil
page ||= 0
name ||= nil
partial_path ||= name
item_is_displayable ||= nil
extra_params ||= {}

if items and count and page and name
  json.count count
  json.page page
  if extra_params.present?
    extra_params.each do |param, value|
      json.set! param, value
    end
  end
  json.items items do |item|
    if item_is_displayable.nil? or (item_is_displayable.is_a?(Proc) and item_is_displayable.(item))
      json.partial! partial_path.to_s, name.to_sym => item
    end
  end
end
