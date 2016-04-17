class Question < ActiveRecord::Base
  
  after_initialize :modify_answer
  before_update :modify_answer
  validates :question, uniqueness: { case_sensitive: true }
  validates_presence_of :answer

  require 'numbers_in_words'
  def is_correct?(submission)
  	#default is to remove white spaces and to lower case the input
  	#when converting number to words, I had to remove "and " because of a bug in the gem
	  submission = submission.to_s.downcase.gsub(/\s+/, '')
	  if(is_a_number(submission))
	  	submission = NumbersInWords.in_words(submission).gsub("and ", "").gsub(/\s+/, '')
	  end
	  answer == submission
  end

  protected

    def modify_answer
      	input = answer.to_s.downcase.strip.gsub(/\s+/, '')
   		if(is_a_number(input))
			input = NumbersInWords.in_words(input).gsub("and ", "").gsub(/\s+/, '')
		end
		self.answer = input
    end

    def is_a_number answer
	  true if Float(answer) rescue false
	end

end
