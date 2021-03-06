require 'spec_helper'

describe Question do
  it 'can create a new question' do
    question = Question.new(question: 'Feeling', long_form: 'How do you feel?')
    expect(question).to be_valid
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:question)).to be_valid
  end

  it 'is not valid without a question' do
    expect(Question.new(question: nil)).to_not be_valid
  end

  it 'is not valid without a long form' do
    expect(Question.new(long_form: nil)).to_not be_valid
  end
end
