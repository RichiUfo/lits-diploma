module Admin
  class SourcesController < BaseController

  	def show
  		@source = Source.find(params[:id])

  		respond_to do |format|
    		format.html # show.html.erb
    		format.xml  { render :xml => @source }
  		end
  	end

  	def edit
		@source = Source.find(params[:id])
	end

	def update
	  @source = Source.find(params[:id])

	  respond_to do |format|
	    if @source.update(source_params)
	      flash[:notice] = 'Post was successfully updated.'
	      format.html { redirect_to admin_sources_path }
	      format.xml  { head :ok }
	    else
	      format.html { render :action => "edit" }
	      format.xml  { render :xml => @source.errors,
		                :status => :unprocessable_entity }
	    end
	  end
	end

	def destroy
	  @source = Source.find(params[:id])
	  @source.destroy

	  respond_to do |format|
	    format.html { redirect_to(admin_sources_path) }
	    format.xml  { head :ok }
	  end
	end

    private

    def set_source
      @source = Source.find(params[:id])
    end

    def source_params
      params.require(:source).permit(:source_type_id, :ref, :created_at, :updated_at, :ext_id, :city_id)
	end

  end
end
