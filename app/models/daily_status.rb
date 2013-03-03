class DailyStatus < ActiveRecord::Base
  unloadable
  default_scope order('created_at desc')
  belongs_to :project

  before_create

  def email_all
    #Mailer.todays_daily_status(self)
  end
end
