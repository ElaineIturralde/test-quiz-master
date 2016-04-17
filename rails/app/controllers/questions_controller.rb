class QuestionsController < ApplicationController
  before_filter :find_question, only: [:show, :edit, :update]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.answer.empty? || @question.question.empty?
      redirect_to :back, notice: 'Input was not saved because question and/or answer were/was empty.'
    elsif @question.save
      render '/questions/answer.html.haml', {question: @question}
    else
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      redirect_to root_path, notice: 'Question saved successfully.'
    else
      render :edit
    end
  end

  def answer
    @answer = find_question.answer
    if is_empty? params
      redirect_to :back, notice: 'Input is blank. Please give an answer.'
    elsif(right_answer(@answer))
      redirect_to root_path, notice: 'You have input the right answer!'
    else
      redirect_to root_path, notice: 'You have input the wrong answer.'
    end
  end

  private

    def is_empty? params
      params["Answer"].empty?
    end

    def right_answer answer
      require 'numbers_in_words'
      input = params["Answer"].to_s.downcase.strip.gsub(/\s+/, '')
      if(is_a_number(input))
        input = NumbersInWords.in_words(input).gsub("and ", "").gsub(/\s+/, '')
      end
      answer == input
    end

    def is_a_number answer
      true if Float(answer) rescue false
    end

    def find_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
