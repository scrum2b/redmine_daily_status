class DailyStatusesController < ApplicationController
  unloadable
  
  before_filter :find_project, :authorize
  before_filter :set_time_zone, :authorize

  def index
    @daily_statuses = @project.daily_statuses.select('id, created_at')
    if !params[:days_ago].blank?
      days = params[:days_ago].to_s.to_i
      if days > 0
        @daily_status = DailyStatus.ago days, @project.id
        if !@daily_status
          flash.now[:notice] = l(:label_last_status_not_available, :days => days)
        end
      end
    end

    @todays_status  = @project.todays_status
    @daily_status ||= @project.daily_statuses.first
    @daily_status ||= @project.daily_statuses.build
  end

  def save

    @daily_statuses = @project.daily_statuses.select('id, created_at')
    @daily_status   = DailyStatus.where(:id => params[:id]).first
    @daily_status ||= @project.daily_statuses.build

    @daily_status.content = params[:daily_status][:content]
      if !params[:daily_status][:is_email_sent].nil?
        @daily_status.is_email_sent = params[:daily_status][:is_email_sent]
      else
        @daily_status.is_email_sent = 0
      end  
    if @daily_status.save
      flash[:notice] = l(:label_status_saved)
      if !params[:daily_status]['is_email_sent'].nil?
        if @daily_status.email_all
          flash[:notice] << l(:label_email_sent_to_all_members)
        end  
      end
    else
      flash[:notice] = @daily_status.errors.full_messages[0]
    end
    
    #render :index
    redirect_to({ :action => 'index'});
  end

  private

  def find_project
    id = params[:project_id].to_s.to_i
    return @project = Project.where(:id => params[:project_id]).first if id > 0
    @project = Project.where(:identifier => params[:project_id]).first
  end

  def set_time_zone
    Time.zone = 'Mumbai'
  end


end
