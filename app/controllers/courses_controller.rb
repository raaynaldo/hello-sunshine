class CoursesController < ApplicationController
    before_action :current_user_is_company?, only: [:new, :create]

    def index
        @courses = Course.all
    end

    def show
        @course = Course.find(params[:id])
           #byebug
    end

    def new
        @course = Course.new
    end
    
    def create
        @course = Course.new(course_params)

        if @course.valid?
            @course.save
            redirect_to company_path(@course.company.id)
        else
             flash.now.alert = "Oops, couldn't create a new course."
            render :new
        end

    end

    def edit
        @course = Course.find(params[:id])
        render :edit
    end

    def update
        @course = Course.find(params[:id])
        @course.update(course_params)

        if @course.valid? 
            @course.save
            redirect_to company_path(@course.company.id)
        else
            flash.now.alert = "Update failed"
            render :edit
        end
    end

    def destroy
        @delete_course = Course.find(params[:id])
        @delete_course.destroy
        redirect_to company_path(@delete_course.company.id)
    end

    def course_params
         params.require(:course).permit(:title, :course_type, :date, :price, :min_age, :max_age, :max_student, :location, :picture, :teacher_id)
    end

    def register
        CourseRegistration.create(course_id: params[:id], student_id: current_user.id)
        redirect_to course_path(params[:id])
    end

    def unregister
        cr = CourseRegistration.where(course_id: params[:id], student_id: current_user.id).first
        cr.destroy
        redirect_to course_path(params[:id])
    end

    private

    def current_user_is_company?
        
        if current_user == nil
            redirect_to login_path(UserType.company_admin)
        end
    end
end
