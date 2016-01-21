# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :topic, uniqueness: true, presence: true

  has_many :tags,
    foreign_key: :topic_id,
    primary_key: :id,
    class_name: 'Tag'

  has_many :urls,
    through: :tags,
    source: :url  
end
