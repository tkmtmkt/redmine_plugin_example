class Detail < ActiveRecord::Base
  unloadable

  belongs_to :project
end
