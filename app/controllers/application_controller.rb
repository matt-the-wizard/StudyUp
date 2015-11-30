class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def require_group
    unless logged_in? && !current_student.study_groups.empty?
      flash[:error] = "You must be logged in and have group to use the section"
      redirect_to search_study_groups
    end
  end

  def _student_params
    params.require(:student).permit(:first_name,
                                    :last_name,
                                    :username,
                                    :password,
                                    :password_confirmation,
                                    :institution,
                                    :school_of_study,
                                    :discipline,
                                    :phone_number)
  end
end
