class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :categories, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
 def self.search(search_word)
    Book.where('title LIKE(?) OR body LIKE(?) OR category LIKE(?)', "%#{search_word}%", "%#{search_word}%", "%#{search_word}%")
  end

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
end
