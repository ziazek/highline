#!/usr/bin/env ruby

# require 'pry-byebug'

module Highline 
  def ask(question, klass = String, within: nil, validate: nil)
    answer = :not_set
    while answer == :not_set do
      puts question
      print "> "
      answer = eval("#{klass}('#{gets.chomp}')")
      if within && !(within === answer)
        raise ArgumentError, "#{answer} is not within #{within}"
      end
      if validate && !(validate === answer)
        raise ArgumentError, "#{answer} does not match #{validate}"
      end
    end
    answer

  rescue ArgumentError => e
    puts "#{e}. Try again."
    retry
  end
  module_function :ask

  def ask_if(question)
    # returns true or false
    puts "#{question} (y or n) "
    print "> "
    answer = gets.chomp
    if answer == "y"
      return true
    elsif answer == "n"
      return false
    else
      raise ArgumentError, "Please enter y or n."
    end

  rescue ArgumentError => e
    puts "#{e}. Try again."
    retry
  end
  module_function :ask_if
end

class HighlineImplementer
  include Highline

  def age
    answer = ask("What is your age?", Integer, within: 0..105)
    return "#age Answer: #{answer}"
  end

  def num
    # binary format: 0b1110_0000_0000_0000
    answer = eval "0b#{ ask('Enter a  binary number.', String, validate: /^[01_]+$/ ) }"
    # eval turns it into an integer.
    return "#num Answer: #{answer}"
  end

  def float
    answer = ask("Enter a float between 0 and 15 inclusive.", Float, within: 0..15)
    return "#float Answer: #{answer}"
  end

  # Ruby built-in conversions don't cover DateTime or Time. 
  
  # def datetime
  #   answer = ask("Enter a date and time.", Time)
  #   return "#datetime Answer: #{answer}"
  # end

  def continuation
    if ask_if("Would you like to continue?")
      return "you did continue."
    else
      return "you did not continue."
    end
  end
end

hl = HighlineImplementer.new
puts hl.age
puts hl.num
puts hl.float
# puts hl.datetime
puts hl.continuation