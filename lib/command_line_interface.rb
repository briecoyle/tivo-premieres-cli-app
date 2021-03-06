require_relative "../lib/scraper.rb"
require_relative "../lib/show.rb"
require_relative "../lib/premiere.rb"
require 'pry'

class CommandLineInterface
  def call
    Premiere.create_from_scraper(Scraper.new.scrape_page)
    puts "Welcome to your Tivo Television Premieres Guide!"
    start
  end

  def start
    puts ""
    puts "Here are the upcoming television premieres!"
    print_premieres
    binding.pry
    puts ""
    puts "Is there a show about which you would like more detailed information? Please enter the show title."
    input = gets.strip
    print_show_details(Show.find_by_title(input))
    puts ""
    puts "Would you like information on another show? Enter Y or N."
    if input == "Y"
      start
    else
      puts ""
      puts "Goodbye."
    end
  end

  def print_premieres
    Premiere.all.each do |premiere|
      puts ""
      puts "#{premiere.day}, #{premiere.month} #{premiere.date}:"
      premiere.shows.each do |s|
        print "s.title"
      end
    end
  end

  def print_show_details(show)
    puts ""
    puts "----- #{show.title} -----"
    puts "Genre: #{show.genre}"
    puts "Network: #{show.network}"
    puts "Time: #{show.time}"
    puts ""
  end
end
