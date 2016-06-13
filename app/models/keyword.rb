class Keyword < ActiveRecord::Base
  belongs_to :site
  has_many :keyword_entries, dependent: :destroy
end
