require_dependency 'project'

module RedminePluginExample
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        has_one :detail, dependent: :destroy
      end
    end
  end
end
