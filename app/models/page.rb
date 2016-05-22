class Page < ActiveRecord::Base
	validates :identifier, presence: true, uniqueness: true
end