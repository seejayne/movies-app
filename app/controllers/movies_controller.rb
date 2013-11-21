class MoviesController < ApplicationController
	def index
		if params[:q].present?
			@movies = Movie.search_for(params[:q])
			
		else
			@movies = Movie.all.order("created_at DESC")
		end
	end

	def new
		@movie = Movie.new
	end

	def create
		#params[:shirt] is a hash with all the ields for the shirt object
		#params[:shirt][:name] is just the name that the user submitted

		@movie = Movie.new( safe_movie_params )
		#logger.info( "my shirt object is #{@shirt.inspect}" )
		@movie.save
		redirect_to root_path
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		@movie.update( safe_movie_params ) #saves for you
		redirect_to movie_path(@movie)
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to root_path
	end



	private #gets called only inside controller

	def safe_movie_params
		return params.require(:movie).permit(:title, :description, :year_released)
	end
end

