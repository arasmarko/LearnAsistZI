class Resource < ActiveRecord::Base

	has_attached_file :asset,
						:url => "/resources/:basename.:extension",
						  :path => ":rails_root/public/resources/:basename.:extension"

	validates_attachment_size :asset, :less_than => 10.megabytes    
	validates_attachment_presence :asset 
	validates_attachment_content_type :asset, 
				:content_type => ["application/pdf","image/jpeg" , "image/png" ,
								 "application/vnd.ms-excel",     
					             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
					             "application/msword", 
					             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
					             "text/plain"],
                :message => ', Only PDF, EXCEL, WORD or TEXT files are allowed. '

	belongs_to :step
	belongs_to :resources_type
	belongs_to :resources_format

end
