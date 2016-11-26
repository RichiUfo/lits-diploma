module Components
  class Link
    LINK_CREATORS = {
      vk: ->(url, ext_id) { "#{url}/event#{ext_id}" },
      fb: ->(url, ext_id) { "#{url}/#{ext_id}" },
      dou: ->(url, ext_id) { "#{url}/calendar/#{ext_id}/" }
    }.freeze

    def self.parse_registration_link(text)
      parse_gform(text)
    end

    def self.parse_gform(text)
      parse_short_gform(text) || parse_full_gform(text)
    end

    def self.parse_short_gform(text)
      text[%r{http\:\/\/goo\.gl\/forms\/[a-zA-Z0-9\/\?\=\&]+}]
    end

    def self.parse_full_gform(text)
      text[%r{https\:\/\/docs\.google\.com\/
        forms\/[a-z]\/[a-z]\/[a-zA-Z0-9\-]+\/[a-zA-Z0-9\/\?\=\&]+}x]
    end

    def self.original_event_url(source_type, ext_id)
      LINK_CREATORS[source_type.name.to_sym].call(source_type.url, ext_id)
    end
  end
end
