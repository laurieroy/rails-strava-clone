class ActivitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_activity, except: %i[index new create]
	before_action :calculate_duration, only: [:create]

	def index
		@activities = current_user.activities.all
	end
	
	def show
		authorize @activity
	end

	def new
		@activity = current_user.activities.build(date: Time.zone.now)
	end

	def create
		@activity = current_user.activities.create(activity_params)
		if @activity.save
			redirect_to @activity, notice: "Created activity"
		else
			render :new, notice: "Problem creating activity, please try again"
		end
	end

	def edit
		authorize @activity
	end

	def update
		authorize @activity
		if @activity.update(activity_params)
			redirect_to @activity, notice: "Updated activity"
		else
			render :edit, notice: "Problem updating activity, please try again"
		end
	end

	def destroy
		authorize @activity
		@activity.destroy
		redirect_to activities_path, notice: "Activity deleted"
	end
	
	private 

	def activity_params
		params.require(:activity).permit(:duration, :distance, :category, :difficulty, :unit, :date, :description)
	end

	# def calculate_duration
	# 	calculated_duration = 0
		
	# 	calculated_duration += params[:activity][:hours].to_i * 3600 if params[:activity][:hours].present?
	# 	calculated_duration += params[:activity][:minutes].to_i * 60 if params[:activity][:minutes].present?
	# 	calculated_duration += params[:activity][:seconds].to_i if params[:activity][:seconds].present?

	# 	params[:activity][:duration] = calculated_duration unless calculated_duration.zero?
	# end

	def calculate_duration
		calculated_duration = 0

		calculated_duration += params[:activity][:hours].to_i * (60 * 60) if params[:activity][:hours].present?
		calculated_duration += params[:activity][:minutes].to_i * 60 if params[:activity][:minutes].present?
		calculated_duration += params[:activity][:seconds].to_i if params[:activity][:seconds].present?

		params[:activity][:duration] = calculated_duration unless calculated_duration == 0
end
	
	def set_activity 
		@activity = Activity.find(params[:id])
	end
end
