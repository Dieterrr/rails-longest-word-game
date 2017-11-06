require 'open-uri'
require 'json'

class LongestwordgameController < ApplicationController
  def game
    @grid = generate_grid(20)
    @start_time = Time.now

  end

  def score

    @end_time = Time.now
    @word = params[:word]
    @grid = params[:grid]
    @start_time = params[:start_time]
    @start_time = Time.parse(@start_time)
    @result = run_game(@word, @grid, @start_time, @end_time)
  end

  private

  def generate_grid(grid_size)
    grid = []
    grid_size.times { grid << (rand(26) + 65).chr }
    grid = grid.join(" ")
    return grid
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/" + word
    data = open(url).read
    result = JSON.parse(data)
    return result["found"]
  end

  def word_in_grid(word, grid)
    puts word
    puts grid
    word.upcase!
    word_array = word.split('')
    word_array.each do |letter|
      if grid.index(letter)
        grid[grid.index(letter)] = ''
      else
        return false
      end
    end
    return true
  end

  def run_game(attempt, grid, start_time, end_time)
    time = end_time - start_time
    return { time: time, score: 0, message: "Not an English word" } unless english_word?(attempt)
    return { time: time, score: 0, message: "Word is not in the grid" } unless word_in_grid(attempt, grid)
    points = (attempt.length * 100) - (time * 10).floor
    return { time: time, score: points, message: "#Well done, #{attempt} is a great choice!" }
  end

end




# GET '/game': render the page with a new random grid of words,
# and the HTML form to write your guess just below the word-grid.

# GET '/score' should compute and display your score..

# require_relative "longest_word"

# puts "******** Welcome to the longest word-game!********"
# puts "Here is your grid:"
# grid = generate_grid(9)
# puts grid.join(" ")
# puts "*****************************************************"

# puts "What's your best shot?"
# start_time = Time.now
# attempt = gets.chomp
# end_time = Time.now

# puts "******** Now your result ********"

# result = run_game(attempt, grid, start_time, end_time)

# puts "Your word: #{attempt}"
# puts "Time Taken to answer: #{result[:time]}"
# puts "Your score: #{result[:score]}"
# puts "Message: #{result[:message]}"

# puts "*****************************************************"



# require 'open-uri'
# require 'json'

# def generate_grid(grid_size)
#   grid = []
#   grid_size.times { grid << (rand(26) + 65).chr }
#   return grid
# end

# def english_word?(word)
#   url = "https://wagon-dictionary.herokuapp.com/" + word
#   data = open(url).read
#   result = JSON.parse(data)
#   return result["found"]
# end

# def word_in_grid(word, grid)
#   word.upcase!
#   word_array = word.split('')
#   word_array.each do |letter|
#     if grid.index(letter)
#       grid[grid.index(letter)] = ''
#     else
#       return false
#     end
#   end
#   return true
# end

# def run_game(attempt, grid, start_time, end_time)
#   time = end_time - start_time
#   return { time: time, score: 0, message: "Not an English word" } unless english_word?(attempt)
#   return { time: time, score: 0, message: "Word is not in the grid" } unless word_in_grid(attempt, grid)
#   points = (attempt.length * 100) - (time * 10)
#   return { time: time, score: points, message: "#Well done, #{attempt} is a great choice!" }
# end
