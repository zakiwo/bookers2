class SendMail < ApplicationRecord
  belongs_to :group
  validates :title, presence: true
  validates :body, presence: true
end
