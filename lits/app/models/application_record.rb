class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  PER_PAGE_DEFAULT = 25
end
