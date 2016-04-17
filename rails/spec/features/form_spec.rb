require 'rails_helper'

RSpec.feature "Forms Management", :type => :feature do

	describe "make a new question" do
		it "should create a new question" do
			expect{
				visit new_question_path
				expect(page).to have_field("Question")
				expect(page).to have_field("Answer")
				fill_in "Question",		:with => "What do you enjoy?"
				fill_in "Answer", 		:with => "Being with my family"
				click_button('Submit', "")
				page.assert_text("Question created successfully!")
				page.assert_text("What do you enjoy?")
				page.assert_text("beingwithmyfamily")
			}.to change(Question, :count).by(1)
		end
		it "should not create a new question" do
			expect{
				visit new_question_path
				expect(page).to have_field("Question")
				expect(page).to have_field("Answer")
				fill_in "Question",		:with => ""
				fill_in "Answer", 		:with => ""
				click_button('Submit', "")
				page.assert_text("Input was not saved because question and/or answer were/was empty.")
			}.to change(Question, :count).by(0)
		end
	end
	describe "answer a question" do
		it "correct answer" do
			@question = FactoryGirl.create(:question)
			visit question_path(@question.id)
			expect(page).to have_field("Answer")
			fill_in "Answer", 		:with => @question.answer
			click_button('Submit answer', "")
			page.assert_text("You have input the right answer!")
			page.assert_text(@question.question)
		end
		it "wrong answer" do
			@question = FactoryGirl.create(:question)
			visit question_path(@question.id)
			expect(page).to have_field("Answer")
			fill_in "Answer", 		:with => "Wrong Answer"
			click_button('Submit answer', "")
			page.assert_text("You have input the wrong answer.")
		end
	end
end