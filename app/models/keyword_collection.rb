class KeywordCollection < ActiveRecord::Base
  belongs_to :site

  def self.upload_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      KeywordCollection.create! row.to_hash
    end
  end
end
