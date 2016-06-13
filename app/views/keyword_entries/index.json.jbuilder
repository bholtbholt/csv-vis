json.array!(@keyword_entries) do |keyword_entry|
  json.extract! keyword_entry, :id
  json.url keyword_entry_url(keyword_entry, format: :json)
end
