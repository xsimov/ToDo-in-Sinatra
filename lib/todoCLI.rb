require 'pry'
require 'json'
require 'HTTParty'

class Viewer
	def self.viewAll
		response = HTTParty.get('http://localhost:9393/api/list')
		if response.length == 0
			puts "Sorry, there are no tasks." 
		else
			puts "To Do:"
			parsed = JSON.parse(response)
			parsed.each_with_index {|value, index| puts "#{index + 1}. #{value}" }
			parsed
		end
	end
	def self.sendNew()
		puts "What do you want to add?"
		value = gets.chomp
		HTTParty.post("http://localhost:9393/beta/save/#{value}")
	end

	def self.delete
		parsed = Viewer.viewAll
		puts "Which one do you want to remove?"
		answer = gets.chomp.to_i
		if (answer <= 0)||(answer.to_f.nan?)||(answer > parsed.length)
			puts "NO!"
		else
			HTTParty.post("http://localhost:9393/beta/del/#{parsed[answer - 1]}")
		end
	end
end

class CLIApp
	def welcome
		puts "Welcome to the most advanced ToDo app!!\n You can:\n 1. See the task list\n 2. Add a task\n 3. Remove a task"
	end
	def menu
		choice = 0
		while (choice < 1) || (choice > 3) || (choice.to_f.nan?)
			choice = gets.chomp.to_i
			case choice
			when 1 
				Viewer.viewAll
			when 2 
				Viewer.sendNew
			when 3 
				Viewer.delete
			else 
				puts "That's not a valid option."
			end
		end
	end
	def workFlow
		welcome
		menu
		flag = true
		while (flag)
		puts "Do you want to exit the program? (Yes/No)"
		answer = gets.chomp.downcase
		# binding.pry
			case answer
			when "no"
				flag = workFlow
			when "yes"
				return false
			else
				flag = false
				puts "That's not a valid option."
			end
		end
		puts "Bye!"
	end
end

CLIApp.new.workFlow