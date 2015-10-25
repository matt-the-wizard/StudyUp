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
    if @study_group.admin_student.id == current_student.id
      render 'edit'
    else
      flash[:error] = 'You cannot edit this group as you do not have admin access.'
      redirect_to :action => :index
    end
  end

  def update
    @study_group = StudyGroup.find params[:id]
    if @study_group.update_attributes(_study_group_params)
      flash[:success] = "Group updated successfully!"
      redirect_to @study_group
    else
      flash[:error] = "There was an error editing your study group."
      @study_group.errors.each do |error|
        flash[:error] = error.to_s
      end
      render 'edit'
    end
  end

  def destroy
    @study_group = StudyGroup.find params[:id]
    if @study_group.admin_student.id == current_student.id
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
    else
      flash[:error] = 'You cannot edit this group as you do not have admin access.'
      redirect_to :action => :index
    end
  end

  def create
    @study_group = StudyGroup.new _study_group_params
    @study_group.admin_student_id = current_student.id
    @study_group.students << current_student
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

  def join
    @study_group = StudyGroup.find(params[:id])
    if @study_group.add_student current_student
      flash[:success] = "You have joined the study group successfully!"
      redirect_to :action => :index
    else
      flash[:error] = "You were unable to join the study group."
      render 'show'
    end
  end

  def leave
    @study_group = StudyGroup.find(params[:id])
    if @study_group.remove_student current_student
      flash[:success] = "You have left the study group successfully!"
      redirect_to :action => :index
    else
      flash[:error] = "You were unable to leave the study group."
      render 'show'
    end
  end

  private

  def _study_group_params
    params.require(:study_group).permit(:title,
                                        :topic,
                                        :institution,
                                        :student_limit)
  end
end
