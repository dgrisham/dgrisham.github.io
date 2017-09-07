gem "minitest"
require 'minitest/autorun'
# for prior versions of Ruby (e.g., 1.9.3), use test/unit
#require 'test/unit'
require_relative "RegexPractice"
include RegexPractice

class RegexPracticeTester < Minitest::Test
  # practice with anchor, character class
  def test_ruby 
	assert_equal(0, RegexPractice.ruby_begins_line("Ruby is fun"))
	assert_equal(0, RegexPractice.ruby_begins_line("ruby rocks"))
	assert_equal(nil, RegexPractice.ruby_begins_line("RUBY rocks"))
	assert_equal(nil, RegexPractice.ruby_begins_line("I love Ruby"))
  end
  
  # practice alternatives. Valid languages are java, ruby, python
  def test_language
	assert_equal(11, RegexPractice.get_language("Gotta love ruby"))
	assert_equal(10, RegexPractice.get_language("Who knows java?"))
	assert_equal(nil, RegexPractice.get_language("Python is easy"))
	assert_equal(4, RegexPractice.get_language("yay python!"))
  end
 
  # Test for complex numbers, including for example -3+4i, +5-6i, +7i, 8i, -12i
  # Potentially uses character classes, repetition, grouping
  def test_complex
    # simple i, 1 or more digits
    assert_equal(0, RegexPractice.get_complex("4i"))
    assert_equal(0, RegexPractice.get_complex("43i"))
    # simple i, 1 or more digits with sign  
    assert_equal(0, RegexPractice.get_complex("-46i"))
    assert_equal(0, RegexPractice.get_complex("+46i"))
    # simple real +/- imaginary
    assert_equal(0, RegexPractice.get_complex("35+46i"))
    assert_equal(0, RegexPractice.get_complex("3-46i"))
    # signed real and signed imaginary
    assert_equal(5, RegexPractice.get_complex("num: -35+46i"))
    assert_equal(0, RegexPractice.get_complex("+3-46i"))
    # a couple non-complex
    assert_equal(nil, RegexPractice.get_complex("abi"))
    assert_equal(nil, RegexPractice.get_complex("65"))    
  end
  
  # Try to use match data for the following - really useful Ruby feature
  def test_cool
    # pre match
	assert_equal("ruby", RegexPractice.what_is_cool("ruby is cool"))
	assert_equal("playing guitar", RegexPractice.what_is_cool("playing guitar is cool"))
	assert_equal(nil, RegexPractice.what_is_cool("java is not cool"))
  end
  
  def test_like
	#post match
	assert_equal("ruby", RegexPractice.what_i_like("I like ruby"))
 	assert_equal("cats and dogs", RegexPractice.what_i_like("I like cats and dogs"))
  end
  
  def test_last_word
   # match, also anchors and character classes
  	assert_equal("wizard", RegexPractice.get_last_word("I want to be a wizard"))
  end
  
  def test_price
    #match, price starts with a $ and then includes dollars.cents
	assert_equal("$32.50", RegexPractice.get_price("The price is $32.50"))
 	assert_equal(nil, RegexPractice.get_price("$32.5"))
 end
end

