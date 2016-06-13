class KeywordEntry < ActiveRecord::Base
  belongs_to :keyword

  def self.upload_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      KeywordEntry.create! row.to_hash
    end
  end
end
