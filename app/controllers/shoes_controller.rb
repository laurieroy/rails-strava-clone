class ShoesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_shoe, except: %i[index new create]

	def index
		# @q = current_user.shoes.ransack(params[:q])
		# @pagy, @shoes = pagy(@q.result(distinct: true))
		@pagy, @shoes = pagy(current_user.shoes.ordered.alphabetized)
	end

	def new
		@shoe = current_user.shoes.build
	end

	def create
		@shoe = current_user.shoes.create(shoe_params)
		respond_to do |format|
			if @shoe.save
				format.html { redirect_to :shoes, notice: "Shoe created" }
				format.js 
			else
				format.html { render :new, notice: "Something went wrong, try again" }
			end
		end
	end

	def edit
		authorize @shoe
	end

	def update
		authorize @shoe
		if @shoe.update(shoe_params)
			redirect_to :shoes, notice: "Shoe updated"
		else
			render :edit, notice: "Something went wrong, try again"
		end
	end

	def destroy
		authorize @shoe
		@shoe.destroy
		redirect_to :shoes, notice: "Shoe deleted"
	end

	private

	def set_shoe
		@shoe = Shoe.find(params[:id])
	end

	def shoe_params
		params.require(:shoe).permit(:name, :retired, :replacement_miles, :user_id)
	end
end
