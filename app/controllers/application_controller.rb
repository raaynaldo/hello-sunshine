class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user
    helper_method :current_type

    def current_user
        # UserType => from config/initializers/my_constants.rb
        if session[:type] == UserType.student
            @current_user ||= Student.find(session[:user_id]) if session[:user_id]
        else
            @current_user ||= CompanyAdmin.find(session[:user_id]) if session[:user_id]
        end
        @current_user
    end
    
    def current_type
        session[:type]
    end

    def was_successful(str)
        flash.now.notice = "#{str.capitalize} wassuccessful"
    end

    def was_failed(str)
        flash.now.alert = "#{str.capitalize} was failed"
    end
end
