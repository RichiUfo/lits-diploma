module Components
  class Link
    @@original_links_creators = {
      vk: -> (url, ext_id) { "#{url}/event#{ext_id}" },
      fb: -> (url, ext_id) { "#{url}/#{ext_id}" },
      dou: -> (url, ext_id) { "#{url}/calendar/#{ext_id}/" }
    }

    def self.parse_registration_link text
      parse_gform(text)
    end

    def self.parse_gform text
      parse_short_gform(text) || parse_full_gform(text)
    end

    def self.parse_short_gform text
      text[/http\:\/\/goo\.gl\/forms\/[a-zA-Z0-9\/\?\=\&]+/]
    end

    def self.parse_full_gform text
      text[/https\:\/\/docs\.google\.com\/forms\/[a-z]\/[a-z]\/[a-zA-Z0-9\-]+\/[a-zA-Z0-9\/\?\=\&]+/]
    end

    def self.original_event_url source_type, ext_id
      @@original_links_creators[source_type.name.to_sym].call(source_type.url, ext_id)
    end
  end
end
