class StudySessionsController < ApplicationController

  def index
    if params[:sessions].present?
      @study_sessions = StudySession.search params[:sessions]
    else
      @study_sessions = StudySession.all.limit(30)
    end
  end

  def show
    @study_session = StudySession.find(params[:id])
  end

  def edit
    @study_session = StudySession.find(params[:id])
  end

  def update
    @study_session = StudySession.find params[:id]
    if @study_session.update_attributes(_study_session_params)
      flash[:success] = "Session updated successfully!"
      redirect_to @study_session
    else
      flash[:error] = "There was an error editing your study session."
      @study_session.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def destroy
    @study_session = StudySession.find params[:id]
    if @study_session.destroy
      flash[:success] = "Session deleted successfully"
      redirect_to study_sessions_url
    else
      flash[:error] = "There was an error deleting your study session."
      @study_session.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def create
    @study_session = StudySession.new _study_session_params

    if @study_session.save
      flash[:success] = "Study Session created successfully!"
      redirect_to @study_session
    else
      flash[:error] = "There was an error creating your study session."
      @study_session.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'new'
    end
  end

  def new
    @study_session = StudySession.new
  end

  def search
     redirect_to :action => :index, :sessions => params
  end

  private

  def _study_session_params
    params.require(:study_session).permit(:location,
                                          :start_time,
                                          :end_time,
                                          :day,
                                          :study_group_id)
  end
end
