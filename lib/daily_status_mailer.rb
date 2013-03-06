class DailyStatusMailer < ActionMailer::Base

  default :sender => 'admin@redmine.com'
  default :content_type => "text/html"

  def send_daily_status(daily_status)
    @recipients = daily_status.project.members.collect {|m| m.user}.collect {|u| u.mail}
    @project_name = daily_status.project.name
    @daily_status_content = daily_status.content
    mail(:to => @recipients, :subject => "Daily Status : "+daily_status.project.name)
  end
end