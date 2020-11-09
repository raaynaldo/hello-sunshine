class CompanyAdminsController < ApplicationController
  def new
    @company_admin = CompanyAdmin.new
    @company_admin.company = Company.new
  end

  def create
    byebug
    @company_admin = CompanyAdmin.new(company_admin_params)
    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @company_admin.email.downcase!
    
    if @company_admin.save
      # If user saves in the db successfully:
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  private

  def company_admin_params
    params.require(:company_admin).permit(:name, :email, :username, :password, :password_confirmation, company_attributes: [:name, :description])
  end
end
