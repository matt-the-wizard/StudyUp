module SessionsHelper

  def log_in(student)
    session[:student_id] = student.id
  end

  def log_out
    forget(current_student)
    session.delete(:student_id)
    @current_student = nil
  end

  def current_student
    if (student_id = session[:student_id])
      @current_student ||= Student.find_by(id: student_id)
    elsif (student_id = cookies.signed[:student_id])
      student = Student.find_by(id: student_id)
      if student && student.authenticated?(cookies[:remember_token])
        log_in student
        @current_student = student
      end
    end
  end

  def logged_in?
    !current_student.nil?
  end

  def remember(student)
    student.remember
    cookies.permanent.signed[:student_id] = student.id
    cookies.permanent[:remember_token] = student.remember_token
  end

  def forget(student)
    student.forget
    cookies.delete(:student_id)
    cookies.delete(:remember_token)
 end
end
