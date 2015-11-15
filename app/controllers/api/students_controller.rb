class Api::StudentsController < ::ApplicationController
  skip_before_action :require_login

  rapid_actions

  def access_profile
    # NOTE: Need authentication token
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

end
