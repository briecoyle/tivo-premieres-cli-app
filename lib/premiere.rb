require 'pry'
require_relative "../lib/show.rb"
require_relative "../lib/scraper.rb"

class Premiere
  attr_accessor :day, :month, :date, :shows
  @@all = []

  def initialize
    @@all << self
  end

  def self.create_from_scraper(scraper_data)
    scraper_data.css(".sublistbig").each do |premiere|
      premiere_array = premiere.text.split("\r\n").grep(/([A-Z]{3}\s*\/\s*\w*\s*\d*)/)[0].strip.split(/\s*\/\s*|\s/)
      new_premiere = Premiere.new
      new_premiere.day = premiere_array[0].capitalize
      new_premiere.month = premiere_array[1]
      new_premiere.date = premiere_array[2]
      binding.pry
    end
  end
  # def self.create_from_scraper(scraper_data)
  #   premieres = []
  #   premieres << scraper_data.text.split("\r\n")
  #   clean_premieres = premieres.flatten!.grep(/([A-Z]{3}\s*\/\s*\w*\s*\d*)/)
  #   clean_premieres.each do |premiere_array|
  #     new_premiere = Premiere.new
  #     new_premiere.day = premiere_array[0]
  #     new_premiere.month = premiere_array[1]
  #     new_premiere.date = premiere_array[2]
  #   end
  #   binding.pry
  # end

  def all
    @@all
  end

  def add_show(new_show)
    self.shows << new_show
    new_show.premiere << self
  end
end

Premiere.create_from_scraper(Scraper.new.scrape_page)
