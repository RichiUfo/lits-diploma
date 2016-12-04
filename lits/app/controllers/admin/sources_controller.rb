module Admin
  class SourcesController < BaseController
    # before_action :url_analyzer, only: [:update, :create]

    def show
    end

    def create
      @source = Source.new(source_params)
      ref = source_params[:ref]
      url_analyzer(ref) unless ref.empty?

      if @source.save
        flash[:notice] = 'Source was successfully created.'
        redirect_to action: 'index'
      else
        flash[:error] = 'Source not created! Wrong url? ' + @source.errors.full_messages.to_sentence
        render action: 'new'
      end
    end

    def edit
    end

    def update
      ref = source_params[:ref]
      url_analyzer(ref) unless ref.empty?

      if @source.update(source_params)
        flash[:notice] = 'Source was successfully updated.'
        redirect_to admin_sources_path
      else
        flash[:error] = 'Source not updated! ' + @source.errors.full_messages.to_sentence
        render action: 'edit'
      end
    end

    private

    def url_analyzer(uri)
      urlstrip = uri
      parsable = urlstrip.to_s.gsub!(%r{[\r\n\t ]}, '').nil? ? uri : urlstrip
      fresh_source = URI.parse(parsable)

      return unless fresh_source.scheme == 'https'
      group = fresh_source.path.gsub(%r{/}, '')
      case fresh_source.host
      when 'facebook.com'
        @source.source_type_id = 2
        @source.ext_id = fb_ext_id(group)
      when 'vk.com'
        @source.source_type_id = 1
        @source.ext_id = vk_ext_id(group)
      when 'dou.ua'
        @source.source_type_id = 3
        # fake ext_id for dou to pass model validation
        @source.ext_id = DateTime.now.to_i
      else
        return
      end
    end

    def fb_ext_id(group)
      oauth = Koala::Facebook::OAuth.new
      @graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      begin
        @graph.get_object(group)['id']
      rescue Koala::Facebook::ClientError => e
        puts e.message
      end
    end

    def vk_ext_id(group)
      @client = VkontakteApi::Client.new
      begin
        @client.groups.getById(group_id: group).last['gid']
      rescue StandardError => e
        puts e.message
      end
    end


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
