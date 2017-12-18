class AdminUser < ActiveRecord::Base
	validates :email, presence: true, uniqueness: true
	validates :username, presence: true, uniqueness: true

	has_many :poems, inverse_of: :admin_user
	has_many :books, inverse_of: :admin_user
	has_many :ebooks, inverse_of: :admin_user
	has_many :retreat_talks, inverse_of: :admin_user
	has_many :audios, inverse_of: :admin_user
	has_many :articles, inverse_of: :admin_user
	has_many :news_articles, inverse_of: :admin_user

	accepts_nested_attributes_for :poems, allow_destroy: true
	accepts_nested_attributes_for :books, allow_destroy: true
	accepts_nested_attributes_for :retreat_talks, allow_destroy: true
	accepts_nested_attributes_for :audios, allow_destroy: true
	accepts_nested_attributes_for :articles, allow_destroy: true
	accepts_nested_attributes_for :news_articles, allow_destroy: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
