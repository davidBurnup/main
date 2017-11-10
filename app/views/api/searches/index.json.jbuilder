if @results
  json.array! @results do |result|
    json.class result.class.to_s
    json.partial! "/api/#{result.class.table_name}/#{result.class.to_s.underscore}", locals: {
      result.class.to_s.underscore.to_sym => result
    }
    if result.respond_to? :search_label
      json.search_label result.search_label
    end
    json.show_url url_for(result)
  end
end
