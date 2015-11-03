namespace :redmine do
  desc 'initialize application'
  task setup: :environment do
    #ユーザー
    User.find(1).update(firstname: '管理者', lastname: 'システム')

    # 設定 ＞ 全般
    Setting.text_formatting = 'markdown'

    # 設定 ＞ 表示
    Setting.default_language = 'ja'
    Setting.user_format = :lastname_firstname

    # 設定 ＞ プロジェクト
    Setting.default_projects_modules = %w(issue_tracking news documents files wiki calendar gantt redmine_plugin_example)

    # 設定 ＞ リポジトリ
    Setting.enabled_scm = %w(Subversion Git)
  end
end
