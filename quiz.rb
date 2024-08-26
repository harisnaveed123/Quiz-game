require 'csv'
require 'optparse'
require 'timeout'

filename = 'problems.csv'
time_limit = 30 # seconds

# Parsing
OptionParser.new do |opts|
  opts.on('-f FILENAME', '--file FILENAME', 'CSV file with quiz questions') do |file|
    filename = file
  end

  opts.on('-t SECONDS', '--time SECONDS', 'Time limit for the quiz in seconds') do |seconds|
    time_limit = seconds.to_i
  end
end.parse!

# Initialize counters
correct_answers = 0
total_questions = 0

# Start quiz
puts "Press Enter to start the quiz..."
gets

# Start the quiz with a timer
begin
  Timeout.timeout(time_limit) do
    CSV.foreach(filename) do |row|
      question, correct_answer = row

      # Increment total questions counter
      total_questions += 1

      puts "Question #{total_questions}: #{question} = ?"
      user_answer = gets.chomp

      if user_answer == correct_answer
        correct_answers += 1
      end
    end
  end
rescue Timeout::Error
  puts "\nTime's up!"
end

# Output
puts "\nQuiz Complete!"
puts "You got #{correct_answers} out of #{total_questions} correct."
