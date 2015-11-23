class Api::StudentsController < ::ApplicationController
  skip_before_action :require_login

  rapid_actions

  permit_params :username,
                :password,
                :first_name,
                :last_name,
                :institution

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

end
