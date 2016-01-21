# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  topic_id   :integer
#  url_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :url_id, presence: true

  belongs_to :tag_topic,
    foreign_key: :topic_id,
    primary_key: :id,
    class_name: 'TagTopic'

  belongs_to :url,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: 'ShortenedUrl'
end
