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
    @result = "This word can't be formed with the available letters"
    if possible?(@guess, @letters)
      @result = exists?(@guess) ? "Nice! \"#{@guess.capitalize}\" is a good choice." : "Sorry, this word doesn't exist..."
    end
    @result
  end

  private

  def exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.parse(url).read
    JSON.parse(word_serialized)['found']
  end

  def possible?(word, letters)
    word.split('').each do |ltr|
      return false unless letters.split.include?(ltr)
    end
    true
  end
end
