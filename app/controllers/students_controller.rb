class StudentsController < ApplicationController
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
