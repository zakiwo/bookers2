class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  is_impressionable counter_cache: true

  scope :six_days_ago, -> {where(created_at: Time.current.ago(6.days).all_day)}
  scope :five_days_ago, -> {where(created_at: Time.current.ago(5.days).all_day)}
  scope :four_days_ago, -> {where(created_at: Time.current.ago(4.days).all_day)}
  scope :three_days_ago, -> {where(created_at: Time.current.ago(3.days).all_day)}
  scope :two_days_ago, -> {where(created_at: Time.current.ago(2.days).all_day)}
  scope :yesterday, -> {where(created_at: Time.current.ago(1.days).all_day)}
  scope :today, -> {where(created_at: Time.current.beginning_of_day..Time.current)}

  scope :this_week, -> {where(created_at: Time.current.ago(6.days).beginning_of_day..Time.current)}
  scope :last_week, -> {where(created_at: Time.current.ago(2.weeks).beginning_of_day..Time.current.ago(1.weeks).end_of_day)}
end
