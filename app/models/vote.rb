class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true

  # def create
  # 	votes.create(user_id: user.id)
  	
  # end

  # def destroy
  # 	votes.find_by(user_id: user.id).destroy
  # end
end
