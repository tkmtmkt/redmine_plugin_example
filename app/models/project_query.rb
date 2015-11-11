class ProjectQuery < Query
  self.queried_class = Project

  self.available_columns = [
    QueryColumn.new(:id, sortable: "#{Project.table_name}.name", default_order: 'desc', caption: '#', frozen: true),
    QueryColumn.new(:project, sortable: "#{Project.table_name}.name", groupable: true),
    QueryColumn.new(:year, sortable: "#{Detail.table_name}.year", groupable: true)
  ]

  def initialize(attributes = nil, *args)
    super attributes
    self.filters ||= {}
    add_filter('year', '*') unless filters.present?
  end

  def initialize_available_filters
    add_available_filter 'year', type: :text

    principals = []
    if project
      principals += project.principals.visible.sort
      unless project.leaf?
        subprojects = project.descendants.visible.to_a
        if subprojects.any?
          add_available_filter(
            'subproject_id',
            type: :list_subprojects,
            values: subprojects.collect { |s| [s.name, s.id.to_s] }
          )
          principals += Principal.member_of(subprojects).visible
        end
      end
    else
      if all_projects.any?
        # members of visible projects
        principals += Principal.member_of(all_projects).visible
        # project filter
        project_values = []
        if User.current.logged? && User.current.memberships.any?
          project_values << ["<< #{l(:label_my_projects).downcase} >>", 'mine']
        end
        project_values += all_projects_values
        add_available_filter(
          'project_id',
          type: :list,
          values: project_values
        ) unless project_values.empty?
      end
    end
    principals.uniq!
    principals.sort!
    users = principals.select { |p| p.is_a?(User) }

    users_values = []
    users_values << ["<< #{l(:label_me)} >>", 'me'] if User.current.logged?
    users_values += users.collect { |s| [s.name, s.id.to_s] }
    add_available_filter(
      'user_id',
      type: :list_optional,
      values: users_values
    ) unless users_values.empty?
  end

  def available_columns
    return @available_columns if @available_columns
    @available_columns = self.class.available_columns.dup
    @available_columns
  end

  def default_columns_names
    @default_columns_names ||= [:project, :spent_on, :user, :activity, :issue, :comments, :hours]
  end

  def project_count
  end

  def project_count_by_group
  end

  def projects(options = {})
    Project.all
  rescue ::ActiveRecord::StatementInvalit => e
    raise StatementInvalid, e.message
  end
end
