class DailyStatusMailer < ActionMailer::Base
  include Redmine::I18n	
  default :sender => 'admin@redmine.com'
  default :content_type => "text/html"

  def send_daily_status(daily_status)
    @recipients = daily_status.project.members.collect {|m| m.user}.collect {|u| u.mail}
    @project_name = daily_status.project.name
    @daily_status_content = daily_status.content
    @login_user_name = User.current.name;
    mail(:to => @recipients, :subject => l(:label_email_subject).to_s+daily_status.project.name)
  end
end