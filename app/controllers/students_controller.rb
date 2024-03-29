class StudentsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    if params[:students].present?
      @students = Student.search params[:students]
    else
      @students = Student.all.limit(30)
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find params[:id]
    if @student.update_attributes(_student_params)
      flash[:success] = "Profile edit successfully"
      redirect_to @student
    else
      flash[:error] = "There was an error editing your account."
      @student.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def destroy
    @student = Student.find params[:id]
    if @student.destroy
      flash[:success] = "Profile deleted successfully"
      redirect_to students_url
    else
      flash[:error] = "There was an error deleting your account."
      @student.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def create
    @student = Student.new _student_params
    if @student.save
      flash[:success] = "Account created successfully!"
      log_in @student
      redirect_to @student
    else
      flash[:error] = "There was an error creating your account."
      @student.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'new'
    end
  end

  def new
    @student = Student.new
  end

  def search
    redirect_to :action => :index, :students => params
  end
end
