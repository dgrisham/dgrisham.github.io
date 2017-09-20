# read blog: http://jroller.com/rolsen/entry/building_a_dsl_in_ruby

require './quiz.rb'
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

		assert_equal("in the morning", answers[0].text)
		assert_equal("Maeby Funke", answers[1].text)
		assert_equal("crazy", answers[2].text)
		assert_equal("Shirley", answers[3].text)

		assert_false(answers[0].correct)
		assert_false(answers[1].correct)
		assert_false(answers[2].correct)
		assert_true(answers[3].correct)
	end
end
