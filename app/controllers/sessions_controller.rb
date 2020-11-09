class SessionsController < ApplicationController
  def new
    render_view
  end

  def create
    # check type user type 
    ##  "0" == student
    ##  "1" == teacher
    if params[:type] == UserType.student
      user = Student.find_by(username: login_params[:username])
    else
      user = CompanyAdmin.find_by(username: login_params[:username])
    end

    # Check if user exist and the password is correct.
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      session[:type] = params[:type]
      redirect_to root_path
    else
      flash.now.alert = "Incorrect username or password, try again."
      render_view
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def login_params
    params.require(:login).permit(:username, :password)
  end

  def render_view
    if params[:type] == UserType.student
      render :student_login
    else
      render :company_login
    end
  end
end
