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
    @tag = Tag.friendly
              .find_by(' LOWER(name) = ? OR id = ? ', params[:id].downcase, params[:id].to_i)
  end

  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
