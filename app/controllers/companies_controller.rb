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
    if company_params[:picture]
        @company.picture.purge
        @company.picture.attach(params[:picture])
        @company.update(company_params)
    end
    if @company.save
      was_successful("update")
      render :show
    else
      was_failed("update")
      render :edit
    end
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :picture)
  end

  def current_user_is_company?
    # redirect to company login page if no curent company.
    return redirect_to login_path(UserType.company_admin) unless current_type

    # redirect to homepage if current user is not a company_admin.
    return redirect_to root_path, alert: "Sorry, You don't have access" unless current_type == UserType.company_admin
  end
end
