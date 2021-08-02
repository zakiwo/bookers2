class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
