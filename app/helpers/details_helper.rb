module DetailsHelper

  def project_list(projects, &block)
    ancestors = []
    projects.each do |project|
      while (ancestors.any? && !project.is_descendant_of?(ancestors.last))
        ancestors.pop
      end
      yield project, ancestors.size
      ancestors << project unless project.leaf?
    end
  end

  def grouped_project_list(projects, query, project_count_by_group, &block)
    previous_group, first = false, true
    project_list(projects) do |project, level|
      group_name = group_count = nil
      if query.grouped? && ((group = query.group_by_column.value(project)) != previous_group || first)
        if group.blank? && group != false
          group_name = "(#{l(:label_blank_value)})"
        else
          group_name = column_content(query.group_by_column, project)
        end
        group_name ||= ""
        group_count = project_count_by_group[group]
      end
      yield project, level, group_name, group_count
      previous_group, first = group, false
    end
  end
end
