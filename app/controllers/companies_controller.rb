class CompaniesController < ApplicationController
  before_action :current_user_is_company?, only: [:edit, :update]

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = Company.find(current_user.company_id)
  end

  def update
    @company = Company.find(current_user.company_id)
    @company.update(company_params)

    if @company.save
        flash.now.notice = "Update succeeded"
        render :show
    else
      flash.now.alert = "Update failed"
      render :edit
    end
  end

  def destroy
  end

  private
  def company_params
    params.require(:company).permit(:name, :description)
  end

  def current_user_is_company?
    # redirect to company login page if no curent company
    return redirect_to login_path(UserType.company_admin) unless current_type

    # redirect to homepage if current user not a company
    return redirect_to root_path, alert: "Sorry, You don't have access" unless current_type == UserType.company_admin
  end
end
