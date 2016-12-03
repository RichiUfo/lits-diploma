module Admin
  class SourcesController < BaseController
    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if @source.update(source_params)
          flash[:notice] = 'Source was successfully updated.'
          format.html { redirect_to admin_sources_path }
        else
          flash[:error] = @source.errors.full_messages.to_sentence
          format.html { render action: 'edit' }
        end
      end
    end

    private

    def source_params
      params.require(:source).permit :source_type_id,
                                     :ref,
                                     :created_at,
                                     :updated_at,
                                     :ext_id,
                                     :city_id
    end
  end
end
