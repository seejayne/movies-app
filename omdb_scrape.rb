require "rest-client"
require "json"

# before beginning
# install rest client and add to Gemfile
# bundle install
# restart server
# create a poster column in db with 'rails generate migration add_poster_to_movies poster:string'
# 'rake db:migrate' to push column to db

def get_posters
	# loop through all movies in database
	movies = Movie.all

	movies.each do |movie|
	# encode the title to account for spaces between words, othewise omdb doesn't like it
	title = URI::encode(movie.title)
	# pull single movie result from omdb with rest-client
	omdb_json = RestClient.get("http://www.omdbapi.com/?i=&t=#{title}")
	# convert to json
	omdb_movie = JSON.load(omdb_json)
	# update the current movie record
	movie.update(poster: omdb_movie["Poster"])
	end
end

get_posters
# use 'rails runner scrape_omdb.rb' to run this script to populate the database
# 'rake db:migrate' to push changes to the db