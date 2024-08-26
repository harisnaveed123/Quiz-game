require 'csv'
require 'optparse'

filename = 'problems.csv'

# Option parsing to allow custom file name via a flag
OptionParser.new do |opts|
  opts.on('-f FILENAME', '--file FILENAME', 'CSV file with quiz questions') do |file|
    filename = file
  end
end.parse!

# counters
correct_answers = 0
total_questions = 0

# Read the CSV file and start the quiz
CSV.foreach(filename) do |row|
  question, correct_answer = row

  total_questions += 1

  puts "Question #{total_questions}: #{question} = ?"
  user_answer = gets.chomp

  # Check if the answer is correct
  if user_answer == correct_answer
    correct_answers += 1
  end
end

# Output
puts "\nQuiz Complete!"
puts "You got #{correct_answers} out of #{total_questions} correct."
