class Message < ApplicationRecord
  belongs_to :admin_user
  belongs_to :receiver, class_name: 'User'

  validates :body, length: { maximum: 160 , too_long: "%{count} characters is the maximum allowed" }
end
