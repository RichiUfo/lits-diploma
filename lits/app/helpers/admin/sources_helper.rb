module Admin::SourcesHelper
  def filtered_source
    SourceType.where.not(name: :dou)
  end

  def cities
    City.all
  end

end
