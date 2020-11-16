class TeachersController < ApplicationController
  before_action :current_user_is_teacher?, only: [:edit, :update]

  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.valid?
      @teacher.picture.attach(params[:teacher][:picture])
      @teacher.save
      redirect_to company_path(@teacher.company_id)
    else
      flash.now.alert = "Create failed"
      render :new
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
    render :new
  end

  def update
    @teacher = Teacher.find(params[:id])
    if teacher_params[:picture]
      @teacher.picture.purge
      @teacher.picture.attach(params[:picture])
    end
    if @teacher.update(teacher_params)
      redirect_to company_path(@teacher.company_id)
    else
      was_failed("update")
      render :new
    end
  end

  def destroy
    teacher = Teacher.find(params[:id])
    @company = teacher.company
    if !teacher.destroy
      flash.now.alert = "Can't delete #{teacher.name} because the teacher has some courses."
    end
    redirect_to company_path(@company)
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :specialty, :hobbies, :website_link, :company_id, :picture)
  end

  def current_user_is_teacher?
    # redirect to teacher login page if no curent user
    return redirect_to login_path(UserType.teacher) unless current_type

    # redirect to homepage if current user not a teacher
    teacher = Teacher.find(params[:id])
    return redirect_to root_path, alert: "Sorry, You don't have access" unless current_type == UserType.company_admin && current_user.company_id == teacher.company_id
  end
end
