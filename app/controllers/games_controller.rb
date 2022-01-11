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
    @letters = params[:letters]
    @guess = params[:word]
    exists?(@guess)
  end

  private

  def exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.parse(url).read
    JSON.parse(word_serialized)['found']
  end
end
