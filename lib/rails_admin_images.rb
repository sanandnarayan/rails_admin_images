require "rails_admin_images/engine"

module RailsAdminImages
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Images < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :object_level do
          true
        end
        register_instance_option :bulkable? do
          true
        end
 
        register_instance_option :controller do
          Proc.new do
						@abstract_model
					 if request.method == "GET"
           		@interior_imgs =@object.image_variants.where(:image_type=>"interior")
           		@exterior_imgs=@object.image_variants.where(:image_type=>"exterior")
           		@generic_imgs=@object.image_variants.where(:image_type=>"generic")
              render :action => @action.template_name
            end
          end
        end
      end
    end
  end
end

