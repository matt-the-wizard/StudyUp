class StudyGroupController < ApplicationController

  def index
    @students = StudyGroup.all.limit(30)
    # Handle search
    # Handle find more
    # Paging gem?
  end

  def show
    @student = StudyGroup.find(params[:id])
  end

  def edit
    @student = StudyGroup.find(params[:id])
  end

  def update
    @student = StudyGroup.find params[:id]
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
    @student = StudyGroup.find params[:id]
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
    @student = StudyGroup.new _student_params
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
    @student = StudyGroup.new
  end

  def search
    #@students = Student.search params[:student_search]
  end

  # private
  #
  # def _student_params
  #   params.require(:student).permit(:first_name,
  #                                   :last_name,
  #                                   :username,
  #                                   :password_digest,
  #                                   :institution,
  #                                   :school_of_study,
  #                                   :discipline,
  #                                   :phone_number)
  # end
end
