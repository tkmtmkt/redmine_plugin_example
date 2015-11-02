class DetailsController < ApplicationController
  unloadable
  before_filter :authorize_global, except: [:show, :edit, :update]
  before_filter :find_project_by_project_id, :authorize, only: [:show, :edit, :update]
  menu_item :detail, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def edit
  end
end
