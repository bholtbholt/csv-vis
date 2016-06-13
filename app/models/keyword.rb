class Keyword < ActiveRecord::Base
  belongs_to :site

  def self.upload_csv(file)
    CSV.foreach(file.path, headers: true) do |row|
      Keyword.create! row.to_hash
    end
  end
end
