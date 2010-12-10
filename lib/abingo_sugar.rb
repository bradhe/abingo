#This module exists entirely to save finger strain for programmers.
#It is designed to be included in your ApplicationController.
#
#See abingo.rb for descriptions of what these do.

module AbingoSugar

  def ab_test(test_name, alternatives = nil, options = {})
    if (Abingo.options[:enable_specification] && !params[test_name].blank?)
      choice = params[test_name]
    elsif (alternatives.nil?)
      choice = Abingo.flip(test_name)
    else
      choice = Abingo.test(test_name, alternatives, options)
    end

    if block_given?
      yield(choice)
    else
      choice
    end
  end

  def bingo!(test_name, options = {})
		# If there is a specific alternative here lets create the test.
		if options[:specific_alternative]
			ab_test(test_name, Abingo.retrieve_alternatives(test_name), options[:specific_alternative])
		end

    Abingo.bingo!(test_name, options)
  end

end
