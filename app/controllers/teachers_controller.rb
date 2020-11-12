class TeachersController < ApplicationController
  before_action :current_user_is_teacher?, only: [:edit, :update]

    def index
        @teachers = Teacher.all
    end

    def show
        @teacher = Teacher.find(params[:id])
    end

    def new
        @teacher = Teacher.new
    end
    
    def create
        @teacher = Teacher.new(teacher_params)
        
        if @teacher.save
            flash.now.notice = "Create succeeded"
            redirect_to company_path(@teacher.company_id)
        else
            flash.now.alert = "Create failed"
            render :new
        end
    end

    def edit
        @teacher = Teacher.find(params[:id])
        render :new
    end

    def update
        @teacher = Teacher.find(params[:id])
        
        if @teacher.update(teacher_params)
            flash.now.notice = "Update succeeded"
            render :show
        else
            flash.now.alert = "Update failed"
            render :new
        end
    end

    def destroy
    end

    private
    def teacher_params
        params.require(:teacher).permit(:name, :specialty, :hobbies, :website_link, :company_id)
    end

    def current_user_is_teacher?
        # redirect to teacher login page if no curent user
        return redirect_to login_path(UserType.teacher) unless current_type
    
        # redirect to homepage if current user not a teacher
        teacher = Teacher.find(params[:id])
        return redirect_to root_path, alert: "Sorry, You don't have access" unless current_type == UserType.company_admin && current_user.company_id == teacher.company_id
      end
end
