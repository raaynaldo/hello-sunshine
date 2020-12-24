class CoursesController < ApplicationController
    before_action :current_user_is_company?, only: [:new, :create]

    def index
        @courses = Course.incoming_courses
        if !!params[:title] && params[:title] != ""
            @courses = @courses.where("title LIKE ? ", "%#{params[:title]}%")
        end
        if !!params[:title] && params[:course_type] != ""
            @courses = @courses.where(course_type: params[:course_type])
        end
        render :index
    end

    def show
        @course = Course.find(params[:id])
        render :show
    end

    def new
        @course = Course.new
        @course.date = DateTime.now
        render :new
    end
    
    def create
        @course = Course.new(course_params)
        if @course.valid?
            @course.picture.attach(params[:course][:picture])
            @course.save
            redirect_to company_path(@course.company.id)
        else
            flash.now.alert = "Oops, couldn't create a new course."
            render :new
        end
    end

    def edit
        @course = Course.find(params[:id])
        render :new
    end

    def update
        @course = Course.find(params[:id])
        if !!course_params[:picture]
            @course.picture.purge
            @course.picture.attach(params[:picture])
        end
        @course.update(course_params)
        if @course.valid? 
            @course.save
            redirect_to company_path(@course.company.id)
        else
            flash.now.alert = "Update failed"
            render :new
        end
    end

    def destroy
        @delete_course = Course.find(params[:id])
        @delete_course.destroy
        redirect_to company_path(@delete_course.company.id)
    end

    def course_params
         params.require(:course).permit(:title, :course_type, :date, :price, :min_age, :max_age, :max_student, :location, :picture, :teacher_id, :search)
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
