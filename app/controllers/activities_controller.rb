class ActivitiesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_activity, except: %i[index new create]

	def index
		@q = current_user.activities.ransack(params[:q])
		@pagy, @activities = pagy(@q.result(distinct: true))
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
			redirect_to @activity, notice: "Activity was updated"
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
		params.require(:activity).permit(:category, :date, :description, :difficulty, :distance, :hours, :minutes, :seconds, :shoe_id, :unit  )
	end
	
	def set_activity 
		@activity = Activity.find(params[:id])
	end
end
