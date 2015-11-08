class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @student = Student.find_by(username: params[:session][:username].downcase)
    if @student && @student.authenticate(params[:session][:password])
      log_in @student
      params[:session][:remember_me] == '1' ? remember(@student) : forget(@student)
      respond_to do |format|
        format.html { redirect_to @student }
        format.json { render json: @student, serializer: StudentSerializer }
      end
    else
      @student.errors.add :base, 'Invalid email/password combination'
      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @student.errors }
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
