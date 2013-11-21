class Movie < ActiveRecord::Base
	def self.search_for( query )
		Movie.where("title LIKE :query OR description LIKE :query", :query => "%#{query}%")
	end	

	before_save :fill_poster

	def fill_poster
		title = URI::encode(self.title)
		omdb_json = RestClient.get("http://www.omdbapi.com/?i=&t=#{title}")
		omdb_movie = JSON.load(omdb_json)
		self.poster = omdb_movie["Poster"]
	end
end
