json.array!(@keywords) do |keyword|
  json.extract! keyword, :id, :site_id, :keywords, :date, :google, :google_base_rank, :yahoo, :bing, :global_monthly_searches
  json.url keyword_url(keyword, format: :json)
end
