class ShoesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_shoe, except: %i[index new create]

	def index
		@shoes = current_user.shoes
	end

	def new
		@shoe = current_user.shoes.build
	end

	def create
		@shoe = current_user.shoes.create(shoe_params)

		if @shoe.save
			redirect_to :shoes, notice: "Shoe created"
		else
			render :new, notice: "Something went wrong, try again"
		end
	end

	def edit
	end

	def update
		if @shoe.update(shoe_params)
			redirect_to :shoes, notice: "Shoe updated"
		else
			render :edit, notice: "Something went wrong, try again"
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
		params.require(:shoe).permit(:name, :retired, :replacement_miles, :user_id)
	end
end
