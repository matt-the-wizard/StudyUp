class StudentsController < ApplicationController

  def index
    @students = Student.all.limit(30)
    # Handle search
    # Handle find more
    # Paging gem?
  end

  def show
    @student = Student.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def create
    @student = Student.new _student_params
    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def new
    @student = Student.new
  end

  def search
    #@students = Student.search params[:student_search]
  end

  private

  def _student_params
    params.require(:student).permit(:first_name,
                                    :last_name,
                                    :username,
                                    :password_digest,
                                    :institution,
                                    :school_of_study,
                                    :discipline)
  end
end
