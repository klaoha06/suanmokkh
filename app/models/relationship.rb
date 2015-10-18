class Relationship < ActiveRecord::Base
	belongs_to :retreat_talk
	belongs_to :related_retreat_talk, :class_name => "RetreatTalk"
end
