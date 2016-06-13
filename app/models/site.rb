class Site < ActiveRecord::Base
  has_many :keywords, dependent: :destroy
  has_many :keyword_entries, through: :keywords, dependent: :destroy

  accepts_nested_attributes_for :keywords, :keyword_entries

  def self.upload_csv(file)
    CSV.foreach(file.path, headers: true, :header_converters => lambda { |h| h.downcase.gsub(' ', '_') }) do |row|
      site = find_by(name: row["site"]) || new
      site.name = row["site"]
      site.save!

      keyword = site.keywords.find_by(name: row["keywords"]) || site.keywords.build
      keyword.name = row["keywords"]
      keyword.save!

      keyword_entry = keyword.keyword_entries.build
      keyword_entry.date = row["date"]
      keyword_entry.google = row["google"]
      keyword_entry.google_base_rank = row["google_base_rank"]
      keyword_entry.yahoo = row["yahoo"]
      keyword_entry.bing = row["bing"]
      keyword_entry.global_monthly_searches = row["global_monthly_searches"]
      keyword_entry.save!
    end
  end
end
