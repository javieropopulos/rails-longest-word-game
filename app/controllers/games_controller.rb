require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @new = ('A'..'Z').to_a.sample(10).join(' ')
  end

  def score
    use_good_letters?
    word_exist?
    end

  def use_good_letters?
    ok = []
    sequence = params[:tags_list].split(' ')
    word = params[:question].upcase.split('')
    word.each do |letter|
      sequence.include?(letter) ? ok << true : ok << false
    end
    ok.include?(false) ? @word = 'Use the good letters' : @word = params[:question]
  end

  def word_exist?
    word = params[:question]
    filepath = "https://wagon-dictionary.herokuapp.com/#{word}"
    answer = JSON.parse(open(filepath).read)
    if answer['found'] == true
      @exist = "Your word is english and the lenght is #{params[:question].length}"
    else
      @exist = 'Your word is not english'
    end
  end
end
