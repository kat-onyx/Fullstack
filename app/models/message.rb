# == Schema Information
#
# Table name: messages
#
#  id         :bigint(8)        not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  channel_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
    validates :body, presence: true

    belongs_to :channel,
        primary_key: :id,
        foreign_key: :channel_id,
        class_name: :Channel
    
    belongs_to :user,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User

    after_create_commit do 
        MessageCreationEventBroadcastJob.perform_later(self)
    end
end
