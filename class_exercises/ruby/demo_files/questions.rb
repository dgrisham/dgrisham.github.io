# read blog: http://jroller.com/rolsen/entry/building_a_dsl_in_ruby

require './quiz.rb'

def question(text)
  Quiz.instance.add_question Question.new(text)
end

def right(text)
  Quiz.instance.last_question.add_answer Answer.new(text,true)
end

def wrong(text)
  Quiz.instance.last_question.add_answer Answer.new(text,false)
end

load 'questions.qm'

require 'test/unit'
class QuizTest < Test::Unit::TestCase

	def test_load_quiz
		# ensure that two questions were loaded
		questions = Quiz.instance.questions
		assert_equal(2, questions.length)
		# ensure that the last question has 4 answers
		question = Quiz.instance.last_question
		answers = question.answers
		assert_equal(4, answers.length)
		assert_equal("U. S. Grant", answers[0].text)
		assert_equal("Cary Grant", answers[1].text)
		assert_equal("Hugh Grant", answers[2].text)
		assert_equal("W. T. Grant", answers[3].text)
		assert_equal(true, answers[0].correct)
		assert_equal(false, answers[1].correct)
		assert_equal(false, answers[2].correct)
		assert_equal(false, answers[3].correct)
		
	end
end

# Quiz.instance.run_quiz

