class Api::StudentsController < ::ApplicationController
  skip_before_action :require_login

  rapid_actions

  def access_profile
    @student = Student.where(username: params[:username]).first
    if @student.present?
      if @student.authenticate params[:password]
        render json: @student, serializer: StudentSerializer
      else
        render json: {"Study Up Authentication Error" => "Invalid password for #{@student.full_name}"}
      end
    else
      render json: {"Study Up Authentication Error" => "User #{params[:username]} does not exist"}
    end
  end

  def create
    @student = Student.new params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :institution)
    if @student.save
      render json: @student, serializer: StudentSerializer
    else
      render json: {"Study Up Authentication Error" => @student.errors}
    end
  end

end
