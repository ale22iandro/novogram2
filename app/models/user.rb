class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :subscribtions, dependent: :destroy

  def subscribed?(user)
    s = Subscribtion.all
    s.where(user_id: self.id, followed_id: user.id).exists?
  end

  def followers_count
    @count = Subscribtion.where(followed_id: self.id).count
  end

  def followed_count
    @f_count = Subscribtion.where(user_id: self.id).count
  end

end
