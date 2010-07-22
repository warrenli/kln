class TasksController < ApplicationController
  def index
    if request.post?
      @message = ""
      task_params = { :description => params[:task][:description],
                      :priority    => params[:task][:priority],
                      :due_on      => params[:task][:due_on] }
      case params[:operation]
      when "new"
        if params[:task][:id]  == "_empty"
          task = Task.create(task_params)
          @message << t('page.tasks.record_added_msg') if task.errors.empty?
        else
          @message << t('page.tasks.add_record_error_msg')
        end
      when "edit"
        task = Task.active.find( params[:task][:id])
        if task.update_attributes(task_params)
          @message << t('page.tasks.changed_msg')
        end
      else
        @message <<  t('page.tasks.unknown_action_msg')
      end
      if task && task.errors
        task.errors.entries.each do |error|
          @message << "<strong>#{Task.human_attribute_name(error[0])}</strong> : #{error[1]}<br/>"
        end
      end
    end
    if request.delete?
      @message = ""
      begin
        Task.active.find(params["id"]).destroy
        @message << t('page.tasks.deleted_msg')
      rescue Exception => e
        @message = e.message
      end
    end
    @tasks = Task.active.paginate :page => params[:page], :per_page => 5
  end

  def new
    @task = Task.new(:description=>"Please enter", :priority => "Low", :due_on => Date.today + 7.days)
  end

  def edit
    @task = Task.active.find(params[:id])
  end
end

