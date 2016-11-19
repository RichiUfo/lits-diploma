module Admin
  class SourcesController < BaseController
    private

    def source_params
      params.fetch(:source, {})
    end
  end
end
