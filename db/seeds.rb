# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
#


# List.create(name: "Crime")
# List.create(name: "Drama")
# movies = []
lists = {}
CSV.foreach('db/movie_data.csv') do |movie|
  next if movie[0].nil?

  hash = {}
  hash[:title] = movie[1]
  hash[:overview] = movie[10]
  hash[:poster_url] = movie[14]

  hash[:rating] = movie[15][49...52].to_f
  this_movie = Movie.create(hash)
  movie[6].split(", ").each do |genre|
    List.create(name: genre)
    lists[genre] = 1
    this_list = List.find_by(name: genre)
    if this_movie.id && this_list.id
      Bookmark.create(movie: this_movie, list: this_list, comment: movie[13])
    end
  end
  # p hash
  # year = year.to_i
  # earnings = earnings.to_i
  # movies << { name: name, year: year, earnings: earnings } if year < max_year
end
p lists
# movies.sort_by { |movie| - (movie[:earnings]) }[...number]
