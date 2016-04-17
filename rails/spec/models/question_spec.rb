require 'rails_helper'

describe Question, :type => :model do
  describe 'is_correct?' do
    it 'requires the correct answer' do
      expect(Question.new(answer: "Paris").is_correct?("London")).to be false
      expect(Question.new(answer: "Paris").is_correct?("Paris")).to be true
    end

    it 'ignores whitespace' do
      expect(Question.new(answer: "  the  moon").is_correct?("the moon")).to be true
      expect(Question.new(answer: "  8        ").is_correct?("8")).to be true
      expect(Question.new(answer: "  1   sun   ").is_correct?("1 sun")).to be true
    end

    it 'ignores case' do
      expect(Question.new(answer: "France").is_correct?("france")).to be true
      expect(Question.new(answer: "MAnilA").is_correct?("Manila")).to be true
      expect(Question.new(answer: "8 COuNtrieS").is_correct?("8 countries")).to be true
    end

    it 'understands numbers as words' do
      expect(Question.new(answer: "7").is_correct?("seven")).to be true
      expect(Question.new(answer: "seven").is_correct?("7")).to be true
      expect(Question.new(answer: "10").is_correct?("ten")).to be true
      expect(Question.new(answer: "ten").is_correct?("10")).to be true
      expect(Question.new(answer: "22").is_correct?("twenty two")).to be true
      expect(Question.new(answer: "twenty two").is_correct?("22")).to be true
      expect(Question.new(answer: "101").is_correct?("one hundred one")).to be true
      expect(Question.new(answer: "one hundred one").is_correct?("101")).to be true
    end
  end
end
