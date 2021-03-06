module Admin
  class SourcesController < BaseController
    # before_action :url_analyzer, only: [:update, :create]

    def create
      @source = Source.new(source_params)
      ref = source_params[:ref]
      url_analyzer(ref) unless ref.empty?

      if @source.save
        flash[:notice] = 'Source was successfully created.'
        redirect_to action: 'index'
      else
        flash[:error] = 'Source not created! ' + @source.errors.full_messages.to_sentence + @error
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
        flash[:error] = 'Source not updated! ' + @source.errors.full_messages.to_sentence + @error
        render action: 'edit'
      end
    end

    private

    def url_analyzer(uri)
      fresh_source = URI.parse(uri.gsub(/\s+/, ''))
      # FIXME
      unless fresh_source.scheme.casecmp('https').zero?
        @error += ' Scheme must be HTTPS!'
        return
      end
      group = fresh_source.path.delete('/')
      case fresh_source.host.sub('www.', '')
      when 'facebook.com', 'fb.com'
        @source.source_type_id = source_type(:fb)
        @source.ext_id = fb_ext_id(group)
      when 'vk.com', 'm.vk.com'
        @source.source_type_id = source_type(:vk)
        @source.ext_id = vk_ext_id(group)
      when 'dou.ua'
        @source.source_type_id = source_type(:dou)
        # fake ext_id for dou to pass model validation
        @source.ext_id = DateTime.now.to_i
      else
        @error += 'Unknown Source' && return
      end
    end

    def fb_ext_id(group)
      oauth = Koala::Facebook::OAuth.new
      @graph = Koala::Facebook::API.new(oauth.get_app_access_token)
      begin
        @graph.get_object(group)['id']
      rescue Koala::Facebook::ClientError => e
        @error += " FB validation: #{e.message}"
      end
    end

    def vk_ext_id(group)
      @client = VkontakteApi::Client.new
      begin
        @client.groups.getById(group_id: group).last['gid']
      rescue StandardError => e
        @error += " VK validation: #{e.message}"
      end
    end

    def source_type(name)
      source = SourceType.pluck(:name, :id).to_h.symbolize_keys
      source[name]
    end

    def source_params
      @error = ''
      params.require(:source).permit :source_type_id,
                                     :ref,
                                     :created_at,
                                     :updated_at,
                                     :ext_id,
                                     :city_id
    end
  end
end
