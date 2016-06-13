json.array!(@keyword_collections) do |keyword_collection|
  json.extract! keyword_collection, :id, :site_id, :keywords, :date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches
  json.url keyword_collection_url(keyword_collection, format: :json)
end
