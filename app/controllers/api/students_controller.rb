class Api::StudentsController < ::ApplicationController
  skip_before_action :require_login

  rapid_actions

  def access_profile
    # NOTE: Need encryption of password sent over the network
    @student = Student.where(username: params[:username]).first
    if @student.authenticate params[:password]
      render json: @student, serializer: StudentSerializer
    else
      @student.errors.add(:base, "Invalid username and password")
      render json: @student.errors
    end
  end
end
