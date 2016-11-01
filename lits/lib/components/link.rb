module Components
  class Link
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
  end
end
