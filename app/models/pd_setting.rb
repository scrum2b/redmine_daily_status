class PdSetting < ActiveRecord::Base
  unloadable
  belongs_to :project
  acts_as_watchable PdSetting     

  def self.dummy project
    sql = "INSERT INTO pd_settings (project_id) VALUES (#{project.id});"
    conn =  ActiveRecord::Base.connection
    conn.execute sql
    where(:project_id => project.id).first
  end
  def self.dummy2 project
    where(:project_id => project.id).first
  end             
end
