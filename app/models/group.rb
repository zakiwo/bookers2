class Group < ApplicationRecord
  attachment :image
  validates :name,uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :send_mails, dependent: :destroy
end
