class MoviesController < ApplicationController
  def index
    @movies = Movie.all.limit(20)
  end
end
