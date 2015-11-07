namespace :redmine do
  namespace :example do
    desc 'initialize application'
    task setup: :environment do
      ####################
      # 管理 ＞ ユーザー
      admin = User.find(1)
      admin.update(firstname: '管理者', lastname: 'システム')

      ####################
      # 管理 ＞ 設定
      # 全般
      Setting.text_formatting = 'markdown'

      # 表示
      Setting.default_language = 'ja'
      Setting.user_format = :lastname_firstname

      # 認証
      Setting.login_required = '0'
      Setting.self_registration = '0'
      Setting.rest_api_enabled = '1'

      # プロジェクト
      Setting.default_projects_public = '0'
      Setting.default_projects_modules =
        %w(issue_tracking news documents files wiki calendar gantt redmine_plugin_example)

      # リポジトリ
      Setting.enabled_scm = %w(Subversion Git)
    end
  end
end
