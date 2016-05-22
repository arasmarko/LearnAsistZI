class Resource < ActiveRecord::Base

	belongs_to :step
	belongs_to :resources_type
	belongs_to :resources_format

end
