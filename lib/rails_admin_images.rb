require "rails_admin_images/engine"

module RailsAdminImages
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Images < Base
        RailsAdmin::Config::Actions.register(self)
        
	      register_instance_option :controller do
          Proc.new do
						@object
					 if request.method != "POST"
           		@interior_imgs =@object.image_variants.where(:image_type=>"interior")
           		@exterior_imgs=@object.image_variants.where(:image_type=>"exterior")
           		@generic_imgs=@object.image_variants.where(:image_type=>"generic")
           		@uncategorized=@object.image_variants.where(:image_type=>"uncategorized")
              render :action => @action.template_name
					 end
					 if request.method == "POST"
							if params[:commit]=="update"
								imgvar=ImageVariant.find(params[:img_id])
							  if	imgvar.update_attributes(:image_type=>params[:img_type])
									render :text=>"updated"
								else
									render :text=>"Error Occured"
								end
							else
								image=Image.new(:image=>params[:image])
								iv=@object.image_variants.new(:image_type=>params[:image_type])
								iv.image = image
								iv.save
		          	flash[:notice]="Image Uploaded"
		          	redirect_to "/admin/variant/#{@object.id}/images"
		          end
           end
          end
        end
        
        register_instance_option :link_icon do
          'icon-refresh'
        end

        # Should the action be visible
        register_instance_option :visible? do
          true
        end
				register_instance_option :member? do
  				true
				end
        register_instance_option :authorized? do
          true
        end

        # Is the action on a model scope (Example: /admin/team/export)
        register_instance_option :collection? do
          false
        end

        # Model scoped actions only. You will need to handle params[:bulk_ids] in controller
        register_instance_option :bulkable? do
          false
        end

        # View partial name (called in default :controller block)
        register_instance_option :template_name do
          key.to_sym
        end

        # For Cancan and the like
        register_instance_option :authorization_key do
          key.to_sym
        end

        # List of methods allowed. Note that you are responsible for correctly handling them in :controller block
        register_instance_option :http_methods do
          [:get, :post]
        end

        # Url fragment
        register_instance_option :route_fragment do
          custom_key.to_s
        end

        # Controller action name
        register_instance_option :action_name do
          custom_key.to_sym
        end

        # I18n key
        register_instance_option :i18n_key do
          key
        end

        # User should override only custom_key (action name and route fragment change, allows for duplicate actions)
        register_instance_option :custom_key do
          key
        end

        # Breadcrumb parent
        register_instance_option :breadcrumb_parent do
          case
          when root?
            [:dashboard]
          when collection?
            [:index, bindings[:abstract_model]]
          when member?
            [:show, bindings[:abstract_model], bindings[:object]]
          end
        end

        def key
          self.class.key
        end

        def self.key
          self.name.to_s.demodulize.underscore.to_sym
        end
        
        
        
      end
    end
  end
end

