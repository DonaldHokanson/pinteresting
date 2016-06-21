class PinsController < ApplicationController
	before_action :set_pin, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@pins = Pin.all
	end

	def show
	end

	def new
		@pin = current_user.pins.build
	end

	def edit
	end

	def create
		@pin = current_user.pins.build(pin_params)
		respond_to do |format|
			if @pin.save
				format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
			else
				format.html { render :new }
			end
		end
	end

	def update
		if @pin.update(pin_params)
			format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
		else
			format.html { render :edit }
		end
	end

	def destroy
		@pin.destroy
		format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
	end

	private
		def set_pin
			@pin = Pin.find(params[:id])
		end

		def correct_user
			@pin = current_user.pins.find_by(id: params[:id])
			redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
		end

		def pin_params
			params.require(:pin).permit(:description)
		end
end
