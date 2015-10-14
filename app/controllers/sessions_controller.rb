class SessionsController < ApplicationController
  def new

  end

  def create
    student = Student.find_by(email: params[:session][:email].downcase)
       if student && student.authenticate(params[:session][:password])
         log_in student
         redirect_to student

       else
         flash[:danger] = 'Invalid email/password combination' #incorrect email
         render 'new'
       end
  end

  def delete
  end
end
