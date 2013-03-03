require 'dispatcher'

module DailyStatusMailer
  def todays_daily_status(daily_status)
    redmine_headers 'X-Project' => daily_status.project.identifier

    subject "#{daily_status.project.name} Daily Status"

    body :daily_status => daily_status, :daily_status_url => "/projects/#{daily_status.project.identifier}/daily_status/#{daily_status.id}"
    render_multipart('daily_status_added', body)
  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods
    receiver.class_eval do
      unloadable
      self.instance_variable_get("@inheritable_attributes")[:view_paths] << RAILS_ROOT + "/vendor/plugins/redmine_contacts/app/views"
    end
  end
end

Dispatcher.to_prepare do
  unless Mailer.included_modules.include?(DailyStatusMailer)
    Mailer.send(:include, DailyStatusMailer)
  end
end