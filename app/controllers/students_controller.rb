class StudentsController < ApplicationController
  def index
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
