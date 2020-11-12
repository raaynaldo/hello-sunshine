class StudentsController < ApplicationController
    before_action :current_user_is_student?, except: [:new, :create]

    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
        @student.email.downcase!

        if @student.save
             # If user saves in the db successfully:
            session[:user_id] = @student.id
            session[:type] = UserType.student
            flash[:notice] = "Account created successfully!"
            redirect_to root_path
        else
            # If user fails model validation - probably a bad password or duplicate email:
            flash.now.alert = "Oops, couldn't create account."
            render :new
        end
    end

    def show
        @student = Student.find(current_user.id)
        render :show
    end

    def edit
        @student = Student.find(current_user.id)
        render :edit
    end

    def update
        @student = Student.find(current_user.id)

        if @student.update(update_student_params)
            was_successful("update")
            render :show
        else
            was_failed("update")
            render :edit
        end
    end

    private
    def student_params
        params.require(:student).permit(:name, :email, :username, :password, :password_confirmation)
    end

    def update_student_params
        params.require(:student).permit(:name, :email)
    end

    def current_user_is_student?
        # redirect to student login page if no curent user
        return redirect_to login_path(UserType.student) unless current_type
        
        # redirect to homepage if current user not a studnet
        return redirect_to root_path, alert: "Sorry, You don't have access" unless current_type == UserType.student
    end
end
