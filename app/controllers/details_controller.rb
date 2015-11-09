#
class DetailsController < ApplicationController
  unloadable
  menu_item :detail, only: [:show, :edit, :update]
  before_action :authorize_global, except: [:show, :edit, :update]
  before_action :find_project_by_project_id, :authorize, only: [:show, :edit, :update]

  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper

  def index
    @query = ProjectQuery.new(name: '_')
    @query.build_from_params(params)
    sort_init(@query.sort_criteria.empty? ? [%w(id desc)] : @query.sort_criteria)
    sort_update(@query.sortable_columns)
    @query.sort_criteria = sort_criteria.to_a

    if @query.valid?
      @limit = per_page_option
      @project_count = @query.project_count
      @project_pages = Paginator.new @project_count, @limit, params['page']
      @offset ||= @project_pages.offset
      @projects = @query.projects(include: [:detail],
                                  order: sort_clause,
                                  offset: @offset,
                                  limit: @limit)
      @project_count_by_group = @query.project_count_by_group

      respond_to do |format|
        format.html { render layout: !request.xhr? }
      end
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def show
  end

  def edit
  end
end
