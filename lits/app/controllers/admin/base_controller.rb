module Admin
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    before_action :set_resource, only: [:destroy, :edit, :show, :update]
    before_action :admin_user!

    respond_to :html
    layout 'admin'

    # GET /admin/{plural_resource_name}
    def index
      plural_resource_name = "@#{resource_name.pluralize}"
      resources = resource_class
                  .where(query_params).order('created_at DESC')
                  .page(pagi_params[:page])
                  .per(20)

      instance_variable_set(plural_resource_name, resources)
      respond_with instance_variable_get(plural_resource_name)
    end

    # GET /admin/{plural_resource_name}/new
    def new
      instance_variable_set("@#{resource_name}", resource_class.new)
      @form_action = 'create'
    end

    # POST /admin/{plural_resource_name}
    def create
      set_resource(resource_class.new(resource_params))
      if resource.save
        redirect_to action: 'index'
      else
        flash[:error] = resource.errors.full_messages.to_sentence
        render action: 'new'
      end
    end

    # DELETE /admin/{plural_resource_name}/1
    def destroy
      resource.destroy
      redirect_to action: 'index'
    end

    # GET /admin/{plural_resource_name}/1
    def show
      respond_with resource
    end

    # GET /admin/{plural_resource_name}/1/edit
    def edit
      @form_action = 'update'
    end

    # PATCH/PUT /admin/{plural_resource_name}/1
    def update
      if resource.update(resource_params)
        # render :show
        redirect_to action: 'index'
      else
        flash[:error] = resource.errors.full_messages.to_sentence
        render action: 'edit'
      end
    end

    private

    def admin_user!
      redirect_to root_path unless user_signed_in? && current_user.roles_mask >= 1
    end

    # Returns the resource from the created instance variable
    # @return [Object]
    def resource
      instance_variable_get("@#{resource_name}")
    end

    # Returns the allowed parameters for searching
    # Override this method in each API controller
    # to permit additional parameters to search on
    # @return [Hash]
    def query_params
      {}
    end

    # Returns the allowed parameters for pagination
    # @return [Hash]
    def pagi_params
      params.permit(:page, :page_size)
    end

    # The resource class based on the controller
    # @return [Class]
    def resource_class
      @resource_class ||= resource_name.classify.constantize
    end

    # The singular name for the resource class based on the controller
    # @return [String]
    def resource_name
      @resource_name ||= controller_name.singularize
    end

    # Only allow a trusted parameter "white list" through.
    # If a single resource is loaded for #create or #update,
    # then the controller for the resource must implement
    # the method "#{resource_name}_params" to limit permitted
    # parameters for the individual model.
    def resource_params
      @resource_params ||= send("#{resource_name}_params")
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource(resource = nil)
      resource ||= resource_class.find(params[:id])
      instance_variable_set("@#{resource_name}", resource)
    end

    def set_locale
      I18n.locale = I18n.default_locale
    end
  end
end
