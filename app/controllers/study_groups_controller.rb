class StudyGroupsController < ApplicationController

  def index
    if params[:groups].present?
      @study_groups = StudyGroup.search params[:groups]
    else
      @study_groups = StudyGroup.all.limit(30)
    end
  end

  def show
    @study_group = StudyGroup.find(params[:id])
  end

  def edit
    @study_group = StudyGroup.find(params[:id])
  end

  def update
    @study_group = StudyGroup.find params[:id]
    if @study_group.update_attributes(_study_group_params)
      flash[:success] = "Group updated successfully!"
      redirect_to @study_group
    else
      flash[:error] = "There was an error editing your study group."
      @student.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def destroy
    @study_group = StudyGroup.find params[:id]
    if @study_group.destroy
      flash[:success] = "Group deleted successfully"
      redirect_to study_groups_url
    else
      flash[:error] = "There was an error deleting your study group."
      @study_group.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def create
    @study_group = StudyGroup.new _study_group_params
    @study_group.admin_student_id = current_student.id if current_student.present?
    # current_student.study_group_id    TODO: Identify how to handle has many to has many relationship
    if @study_group.save
      flash[:success] = "Study Group created successfully!"
      redirect_to @study_group
    else
      flash[:error] = "There was an error creating your study group."
      @study_group.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'new'
    end
  end

  def new
    @study_group = StudyGroup.new
  end

  def search
     redirect_to :action => :index, :groups => params
  end

  private

  def _study_group_params
    params.require(:study_group).permit(:title,
                                        :student_id,
                                        :topic,
                                        :institution,
                                        :student_limit,
                                        :study_group_id)
  end
end
