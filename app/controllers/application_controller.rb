class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user

    def current_user
        if session[:type] == "0"
            @current_user ||= Student.find(session[:user_id]) if session[:user_id]
        else
            @current_user ||= Teacher.find(session[:user_id]) if session[:user_id]
        end
        @current_user
    end
end
