class AdminUser < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true
	validates :username, presence: true, uniqueness: true

	has_many :poems
	has_many :books
	has_many :audios
	has_many :videos
	has_many :articles
	has_many :news_articles

	accepts_nested_attributes_for :books, allow_destroy: true
	accepts_nested_attributes_for :poems, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :articles, allow_destroy: true
	accepts_nested_attributes_for :news_articles, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
