class CoursesController < ApplicationController
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
    end

    def edit
    end

    def update
    end

    def destroy
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
end
