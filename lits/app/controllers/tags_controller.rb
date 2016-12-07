class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]
  attr_reader :tag

  def index
    @tags = Tag.all
  end

  def show
    @events = Event.future.by_tag(@tag).page(@page)
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id].to_s.downcase)
  end

  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
