class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
    @events = Event.future.by_tag(@tag).page(@page)
  end

  def page_title
    title = Rails.application.config.app_name
    title + if action_name == 'index'
              ' | Все теги'
            elsif action_name == 'show'
              " | #{@tag.name}"
            else
              ''
            end
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
