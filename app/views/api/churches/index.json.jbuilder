json.array! @churches do |church|
  json.partial! "church", church: church
end
