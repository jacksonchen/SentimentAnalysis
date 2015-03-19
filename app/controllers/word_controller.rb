require 'csv'
require 'open-uri'

class WordController < ApplicationController
  def index

  end

  def processing
    if Value.count.zero?
      file_data = open("http://www.chenjackson.com/word_values.csv")
      if file_data.respond_to?(:read)
        database_setup(file_data)
        #flash[:success] = "Upload successful"
        #render :index
      else
        flash[:error] = "File error"
        #redirect_to root_path
      end
    end

    words = params[:word_string].split(/[\s,.;]/)
    words.each do |word|
      word = word.gsub(/[\.,;]/,'')
      if word.empty?
        words.delete(word)
      end
    end
    value = 0
    words.each do |theword|
      thevalue = Value.where(word: theword)[0]
      if !thevalue.nil?
        value = value + thevalue.value
      end
    end
    flash[:alert] = "Your string: " + params[:word_string]
    if value < 0
      if value < 1
        flash[:success] = "Predicted mood: Happy"
      else
        flash[:success] = "Predicted mood: Very joyous"
      end
    elsif value > 0
      if value > -1
        flash[:success] = "Predicted mood: Grumpy"
      else
        flash[:success] = "Predicted mood: Mad"
      end
    else
      flash[:success] = "Predicted mood: Neutral"
    end
    render :index

  end

  private

  def database_setup(file_data)
    file_contents = CSV.parse(file_data)
    Value.delete_all
    file_contents.each do |line|
      word_value = Value.new()
      word_value.word = line[0]
      word_value.value = line[1]
      word_value.save
    end
  end
end
