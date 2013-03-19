require 'daily_status_mailer'
class DailyStatus < ActiveRecord::Base
  unloadable
  default_scope order('created_at desc')
  belongs_to :project
  validates_presence_of :content

  acts_as_event :author => nil,
                :datetime => :created_at,
                :description => :content,
                :title => :content

  acts_as_activity_provider :timestamp => "#{table_name}.created_at",
                            :find_options => {:include => :project,
                                            :select => "#{table_name}.*"},
                            :permission => :view_daily_status

  def email_all
    DailyStatusMailer.send_daily_status(self).deliver
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
