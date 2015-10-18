class SessionsController < ApplicationController
  def new
  end

  def create
    student = Student.find_by(username: params[:session][:username].downcase)
    if student && student.authenticate(params[:session][:password])
      log_in student
      params[:session][:remember_me] == '1' ? remember(student) : forget(student)
      redirect_to student
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
