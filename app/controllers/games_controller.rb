require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ["y", "d", "z", "u", "q", "a", "p", "r", "y", "i", "o"]
  end

  def score
    @word = params[:word]
    @letters = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    valid_word = JSON.parse(URI.open(url).read)
    @message = if !include?(@letters, @word)
                 "Sorry but #{@word} cannot be built out of #{@letters}"
               elsif include?(@letters, @word) && (valid_word['found'] == false)
                 "Sorry but #{@word} does not seem to be a valid English word..."
               elsif include?(@letters, @word) && (valid_word['found'] == true)
                 "Congratulations! #{@word} is a valid English word!"
               end
  end

  def include?(grid, word)
    word_arr = word.split('')
    word_arr.each do |letter|
      amount_in_grid = grid.split('').count(letter)
      amount_in_word = word_arr.count(letter)

      if amount_in_word > amount_in_grid
        return false
      end
    end
    true
  end
end
