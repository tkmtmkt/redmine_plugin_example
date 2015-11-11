namespace :redmine do
  namespace :example do
    desc 'load dummy data'
    task load_dummy_data: :environment do
      RedminePluginExample::DummyDataLoader.load
    end
  end
end
