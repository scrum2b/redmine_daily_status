require 'daily_status_mailer'
class DailyStatus < ActiveRecord::Base
  unloadable
  default_scope order('created_at desc')
  belongs_to :project
  validates_presence_of :content

  acts_as_event :author => nil,
                :datetime => :created_at,
                :description => :content,
                :title => :content,
                :url =>Proc.new {
                                  |o|
                                  {
                                      :controller => 'daily_statuses',
                                      :action => 'index',
                                      :project_id => o.project ,
                                      :day => (o.created_at.to_date).to_s
                                  }
                                }

  acts_as_activity_provider :timestamp => "#{table_name}.created_at",
                            :find_options => {
                                                :include => :project,
                                                :select => "#{table_name}.*",
                                                :conditions => "#{table_name}.is_email_sent=1"
                                              },
                            :permission => :view_daily_status
                            

  def email_all project_daily_status
    DailyStatusMailer.send_daily_status(self,project_daily_status).deliver
  end

  def self.on time, project_id
    where(:project_id => project_id).where("DATE(created_at) = DATE(?)", time).first
  end

  def self.ago number_of, project_id
    #on Time.now-number_of.days, project_id
    on Date.today-number_of.days, project_id
  end

  def self.todays_status_for project
    where(:project_id => project.id).where("created_at >= ? and created_at <= ?", Date.today.beginning_of_day, Date.today.end_of_day).first
  end

end
