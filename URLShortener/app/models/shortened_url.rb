# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true

  belongs_to :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: 'User'

  has_many :visits,
    foreign_key: :visited_url_id,
    primary_key: :id,
    class_name: 'Visit'

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  has_many :tags,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: 'Tag'

  has_many :topics,
    through: :tags,
    source: :tag_topic

  def self.random_code
    loop do
      code = SecureRandom.urlsafe_base64
      return code unless ShortenedUrl.exists?(short_url: code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    shortened_url = ShortenedUrl.new
    shortened_url.submitter_id = user.id
    shortened_url.long_url = long_url
    shortened_url.short_url = self.random_code
    shortened_url.save!
    shortened_url
  end

  def num_clicks
    Visit.select(:visitor_id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    Visit.select(:visitor_id).where(created_at: (10.minutes.ago..Time.now)).distinct.count
  end
end
