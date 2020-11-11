class StudentsController < ApplicationController
    def show
        # check if the user is student
        if current_type == UserType.student
            # check if current user id same as parameter
            if params[:id].to_i == current_user.id
                @student = Student.find(params[:id])
                render :show
            else
                # redirect to current student id
                redirect_to student_path(current_user.id)
            end
        else
            redirect_to root_path
        end
    end

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

    private
    def student_params
        params.require(:student).permit(:name, :email, :username, :password, :password_confirmation)
    end
end
