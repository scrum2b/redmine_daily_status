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

module DailyStatusProjectPatch
  def self.included(base)
    base.class_eval do
      unloadable
      has_many :daily_statuses
    end
  end
end

Project.send(:include, DailyStatusProjectPatch)
