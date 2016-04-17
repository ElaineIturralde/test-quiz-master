require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe "#index" do
    subject { get :index } 
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      expect(subject).to render_template(:index)
      expect(subject).to render_template("index")
      expect(subject).to render_template("questions/index")
    end
  end

  describe "#new" do
    subject { get :new }  
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      expect(subject).to render_template(:new)
      expect(subject).to render_template("new")
      expect(subject).to render_template("questions/new")
    end
  end

  describe "#create" do
    it "creates a new question" do 
      expect { post :create, :question => FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
    end
    it "does not create a new question if duplicate" do 
      expect { post :create, :question => FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(1)
      expect { post :create, :question => FactoryGirl.attributes_for(:question) }.to change(Question, :count).by(0)
    end
  end

  describe "#update" do
    it "updates the question", focus: true do
      @question = FactoryGirl.create(:question)
      put :update, id: @question, question: attributes_for(:question, question: "Favorite language?")
      @question.reload
      expect(@question.question).to eq("Favorite language?")
    end
    it "updates the answer", focus: true do
      @question = FactoryGirl.create(:question)
      put :update, id: @question, question: attributes_for(:question, answer: "upd")
      @question.reload
      expect(@question.answer).to eq("upd")
    end
  end

end
