# == Schema Information
#
# Table name: visits
#
#  id             :integer          not null, primary key
#  visitor_id     :integer
#  visited_url_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true
  validates :visited_url_id, presence: true

  belongs_to :visitor,
    foreign_key: :visitor_id,
    primary_key: :id,
    class_name: 'User'

  belongs_to :shortened_url,
    foreign_key: :visited_url_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'

  def self.record_visit!(user, shortened_url)
    options = {
      visitor_id: user.id,
      visited_url_id: shortened_url.id
    }
    Visit.create!(options)
  end


end
