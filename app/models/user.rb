class User < ApplicationRecord
  attr_accessor :current_password
  mount_uploader :image, ImageUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 10 }
  validates :profile, length: { maximum: 200 }
  validate :password_complexity
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[a-z])(?=.*?[0-9]).{6,20}$/
    errors.add :password, 'の長さは6文字から20文字の間にして下さい。半角英字小文字(a-z)、数字(0-9)を少なくともひとつずつ組み合わせてください。'
  end

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_photos, through: :likes, source: :photo
  def already_liked?(photo)
    self.likes.exists?(photo_id: photo.id)
  end

  has_many :following_relationships, class_name: 'Relationship', foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  def follow(other_user)
    unless self == other_user
      self.following_relationships.find_or_create_by(following_id: other_user.id)
    end
  end
  def unfollow(other_user)
    relationship = self.following_relationships.find_by(following_id: other_user.id)
    relationship.destroy if relationship
  end
  def following?(other_user)
    self.followings.include?(other_user)
  end

  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :messages, dependent: :destroy
end

