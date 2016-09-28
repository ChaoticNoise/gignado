class ApplicationJob < ActiveJob::Base
  include ActiveJobStatus::Hooks
end
