class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, length: { minimum: 2 , maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #フォローする側
  has_many :followers, through: :relationships, source: :followed
  #フォローしている人一覧
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #フォローされる側
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  #フォローされている人一覧
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :inquiries, dependent: :destroy

  def following?(user)
    relationships.find_by(followed_id: user.id).present?
  end

  attachment :profile_image

end
