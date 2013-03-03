class DailyStatusesController < ApplicationController
  unloadable

  before_filter :find_project, :authorize

  def index
    @daily_statuses = @project.daily_statuses.select('id, created_at')

    unless params[:days_ago].blank?
      days = params[:days_ago].to_s.to_i
      if days > 0
        @daily_status = DailyStatus.ago days, @project.id
        flash[:notice] = "#{days} days ago status not available." unless @daily_status
      end
    end

    @daily_status ||= @project.daily_statuses.first
    @daily_status ||= @project.daily_statuses.build
  end

  def save
    @daily_statuses = @project.daily_statuses.select('id, created_at')
    @daily_status   = DailyStatus.where(:id => params[:id]).first
    @daily_status ||= @project.daily_statuses.build

    @daily_status.content = params[:daily_status][:content]
    if @daily_status.save
      flash[:notice] = 'Status Saved'
      flash[:notice] << ', and mail has been sent to all members.' if @daily_status.email_all
    else
      flash[:notice] = @daily_status.errors.full_messages[0]
    end
    
    render :index
  end

  private

  def find_project
    id = params[:project_id].to_s.to_i
    return @project = Project.where(:id => params[:project_id]).first if id > 0
    @project = Project.where(:identifier => params[:project_id]).first
  end
end
