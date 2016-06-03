require 'random/online'

class Mastermind
	@@availablecolors = ["yellow", "blue", "green", "red", "purple", "white"] 
	@@code = []
	@@guesses = []
	@@feedbacks = []
	@@gameover = false  


	def codesetter
        4.times do 
        	@@code << @@availablecolors[rand(5)]
        	@@availablecolors.shuffle
        end

	end

	def codebreakerguess
		peg = 1
		guess = []
		puts "Guees 4 colors from #{@@availablecolors.join(", ")}"
		while peg < 5 
			puts "Your Peg #{peg} is?"
			input = gets
			     if @@availablecolors.index(input.chomp.downcase)
                         puts "OK"
			             guess << input.chomp.downcase
			             peg += 1

			     else 
			     	puts "Your input is not ok"
			     end
		end

		@@guesses << guess

		return guess

	end


	def feedback(guess)
		feedback = []
		# puts guess
		# puts @@code
		guess.each_with_index do |peg, index|
			if guess[index] == @@code[index]
				puts guess[index]
				puts @@code[index]
				feedback << "red"
			elsif @@code.include?(peg)
				feedback << "white"
			else
			    feedback << " "
			end
		end	
		@@feedbacks << feedback



		puts '/////////////////////////////////////////'
		puts "The guess is"
		puts guess.join(", ")
		puts "-----------------------------------------"
		puts 'The feedback on the last guess'
		puts feedback.join(", ")
		puts '/////////////////////////////////////////'

	end

	def playercodesetter
		peging = 1
		puts "Lets set the code!"
		puts "Choose 4 colors from #{@@availablecolors.join(", ")}"
		while peging < 5 
			puts "The Peg #{peging} is?"
			input = gets
			     if @@availablecolors.index(input.chomp.downcase)
                         puts "OK"
			             @@code << input.chomp.downcase
			             peging += 1

			     else 
			     	puts "Your input is not ok"
			     end	     
		end
		puts "Your code is #{@@code.join(", ")}"
	end	


	def start 
		puts "Do you want to be a codemaker(1) or a guesser(2). Choose 1 or 2"
		answer = gets.chomp.to_i
		

		# here the player sets the code and the computer is trying to break it. Sort of AI. 
		if answer == 1
			puts "/////////////////////////////////"
			puts "Let's start!!!"
			#first we ask the player to set the code
			playercodesetter
			#the we create a loop with which the computer is trying to guess the number
			guessnumber = 1
			until guessnumber > 12 || @@gameover == true
			
				puts "Computer guess number #{guessnumber}"
				#computer is trying to randomly guess colors first
				k = []
				k << @@availablecolors.sample(4)
				@@guesses << k
				puts k.join(", ")
				# puts "Your code is #{@@code.join(", ")}"
				feedback(k)
			    if @@code == k
				   puts "The Game is Over. The Computer has won"
				   @@gameover == true
				   break
			    else
			       #here computer needs to receive feedback on its guess
				   guessnumber += 1
				   # puts "Your code is #{@@code.join(", ")}"
			    end	    

			end
			puts "Computer has lost!"
		




		# here computer sets the code and the gusser is trying to break it
		elsif answer == 2
			puts "/////////////////////////////////"
			puts "Let's start!!!"
			codesetter #computer sets the code
			guessnumber = 1
			until guessnumber > 12 || @@gameover == true
			
				puts "Your guess number #{guessnumber}"
				k = codebreakerguess
				feedback(k)
			    if @@code == k
				   puts "The Game is Over. The Player has won"
				   @@gameover == true
				   break
			    else 
				   
				   guessnumber += 1
			    end	    

			end
			puts "You've lost!"

		else
		   puts "Your input in incorrect!!!" 
		   start
		end
		
	end 
end

game1 = Mastermind.new
game1.start
