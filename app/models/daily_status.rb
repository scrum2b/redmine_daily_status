require 'daily_status_mailer'
class DailyStatus < ActiveRecord::Base
  unloadable
  default_scope order('created_at desc')
  belongs_to :project

  before_create

  def email_all
    DailyStatusMailer.send_daily_status(self).deliver
  end

  def title
    #return "Today's Status" if created_at.today?
    #return "Yesterday's Status" if created_at.yesterday?
    #{}"Status on #{created_at.strftime('%b %-d')}"
  end

  def self.on time, project_id
    where(:project_id => project_id).where("DATE(created_at) = DATE(?)", time).first
  end

  def self.ago number_of, project_id
    on Time.now-number_of.days, project_id
  end
end
