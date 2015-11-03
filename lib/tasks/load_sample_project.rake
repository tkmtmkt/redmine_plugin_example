namespace :redmine do
  desc 'Create Sample Project'
  task load_sample_project: :environment do
    project = Project.new(
      name: 'サンプルプロジェクト',
      identifier: 'sample'
    )

    project.enabled_module_names = %w(issue_tracking news documents files wiki calendar gantt redmine_plugin_example)

    member = Member.new(
      user_id: 1,
      roles: [Role.find(3)]
    )
    project.memberships = [member]

    trackers = Tracker.all
    priorities = IssuePriority.all
    60.times.each_with_index do |i|
      issue = Issue.new(
        tracker_id: trackers[rand(trackers.size)].id,
        subject: "サンプル#{i}",
        status_id: 1,
        priority_id: priorities[rand(priorities.size)].id,
        author_id: 1
      )
      project.issues << issue
    end

    begin
      project.save!
    rescue => e
      puts 'Error: ' + e.message
    end
  end
end
