class Step < ActiveRecord::Base

	has_many :to_dos
	has_many :notes
	has_many :resources
	belongs_to :goal
	
end
