#
module RedminePluginExample
  module DummyDataLoader
    PROJECT_COUNT = 2
    ISSUE_COUNT = 100
    JOURNAL_COUNT = 20
    START_DATE = Time.zone.today.years_ago(1) - PROJECT_COUNT * 3

    class << self
      def load
        PROJECT_COUNT.times.each do |i|
          begin
            project = create_project(i + 1)
            puts ">>>>> #{project.name} (#{project.created_on.strftime('%x')})"
            create_issues(project, ISSUE_COUNT)
          rescue => e
            puts e.message
          end
        end
      end

      private

      def create_project(index)
        id = format('%05d', index)
        project_id = "dummy-#{id}"
        project = Project.where(identifier: project_id).first
        project ||= Project.create!(
          name: "ダミープロジェクト #{id}",
          identifier: project_id,
          created_on: START_DATE + index * 3)
        @trackers ||= Tracker.all
        project.trackers = @trackers
        project
      end

      def create_issues(project, count)
        return unless project
        return unless count > project.issues.count

        @trackers ||= Tracker.all
        @priorities ||= IssuePriority.all
        ((project.issues.count + 1)..count).to_a.each do |i|
          issue = project.issues.create!(
            tracker_id: @trackers[rand(@trackers.size)].id,
            subject: "ダミーチケット #{format('%05d', i + 1)}",
            status_id: 1,
            priority_id: @priorities[rand(@priorities.size)].id,
            author_id: 1,
            lock_version: 4,
            done_ratio: 0,
            root_id: 1,
            lft: 1,
            rgt: 2,
            is_private: false)
          date = project.created_on.to_date + i
          issue.update(start_date: date, created_on: date)
          create_journals(issue, JOURNAL_COUNT)
        end
      end

      def create_journals(issue, count)
        return unless issue
        return unless count > issue.journals.count

        ((issue.journals.count + 1)..count).to_a.each do |i|
          journal = issue.journals.create!(
            user_id: 1,
            notes: "コメント #{format('%05d', i + 1)}")
          journal.update(created_on: issue.created_on.to_date + 1)
        end
      end
    end
  end
end
