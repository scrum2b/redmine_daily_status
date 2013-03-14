require 'redmine'

Redmine::Plugin.register :redmine_daily_status do
  name 'Daily Status'
  author 'Amol Pujari, Vishal Mene'
  description 'Consolidated Team Daily Status'
  version '0.0.1'
  url 'https://github.com/gs-lab/redmine_daily_status'
  author_url 'https://github.com/gs-lab/redmine_daily_status'

  project_module :daily_status do
    permission :view_daily_status,   :daily_statuses => :index
    permission :manage_daily_status, :daily_statuses => :save
  end
 
  menu :project_menu, :daily_statuses,
    { :controller => 'daily_statuses', :action => 'index' },
    :caption => :daily_status,
    :after => :activity,
    :param => :project_id
end

require_dependency 'daily_status_project_patch'
require 'daily_status_mailer'

require 'dispatcher'   
module RedmineDailyStatus
  module Patches    
    module MailerPatch
      module InstanceMethods
        def send_daily_status(daily_status)
          @recipients = daily_status.project.members.collect {|m| m.user}.collect {|u| u.mail}
          @project_name = daily_status.project.name
          @daily_status_content = daily_status.content
          @login_user_name = User.current.name;
          mail(:to => @recipients, :subject => l(:label_email_subject).to_s+daily_status.project.name)
        end
      end  

      def self.included(receiver)
        receiver.send :include, InstanceMethods
        receiver.class_eval do 
          unloadable   
          self.instance_variable_get("@inheritable_attributes")[:view_paths] << RAILS_ROOT + "/vendor/plugins/redmine_daily_status/app/views"
        end  
      end
    end
  end
end

Dispatcher.to_prepare do  
  unless Mailer.included_modules.include?(RedmineDailyStatus::Patches::MailerPatch)
    Mailer.send(:include, RedmineDailyStatus::Patches::MailerPatch)
  end   
end