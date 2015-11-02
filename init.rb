Redmine::Plugin.register :redmine_plugin_example do
  name 'Redmine Plugin Example plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


  permission :manage_details, { details: [:index] }, require: :member

  project_module :redmine_plugin_example do
    permission :manage_detail, { details: [:show, :edit, :update] }, require: :member
  end

  menu :application_menu, :details, { controller: :details, action: :index },
    caption: :label_details, before: :issues, param: :project_id

  menu :project_menu, :detail, { controller: :details, action: :show },
    caption: :label_details, before: :issues, param: :project_id
end
