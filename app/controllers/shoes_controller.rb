class ShoesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_shoe, except: %i[index new create]

	def index
		# @shoes = Shoe.all
	end

	def show
	end

	def new
		@shoe = current_user.shoes.build
	end

	def create
		@shoe = current_user.shoes.create(shoe_params)

		if @shoe.save
			redirect_to :shoes, notice: "Shoe created"
		else
			render :new
		end
	end

	def destroy
		@shoe.destroy
		redirect_to :shoes, notice: "Shoe deleted"
	end

	private

	def set_shoe
		@shoe = Shoe.find(params[:id])
	end

	def shoe_params
		params.require(:shoe).permit(:name, :retired, :replacement_miles)
	end
end
