# Games controller
class GamesController < ApplicationController
  def new
    @letters = []
    alpbt = ('a'..'z').to_a

    until @letters.length == 10
      ltr = alpbt.sample
      @letters << ltr unless @letters.include?(ltr)
    end
    @letters
  end

  def score
    @guess = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    word_serialized = URI.open(url)
    @result = JSON.parse(word_serialized)
  end
end
