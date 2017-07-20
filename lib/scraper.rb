require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|

      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_profile_url = card.css("a").first.attributes["href"].value
      student = {name: student_name, location: student_location, profile_url: student_profile_url}
      scraped_students.push(student)
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |container|
      if container.attributes["href"].value.include? "linkedin"
        student[:linkedin] = container.attributes["href"].value
      elsif container.attributes["href"].value.include? "twitter"
        student[:twitter] = container.attributes["href"].value
      elsif container.attributes["href"].value.include? "github"
        student[:github] = container.attributes["href"].value
      else
        student[:blog] = container.attributes["href"].value
        # student[:blog] = doc.css("div .social-icon-container a")[3].attributes["href"].value

      end

    end


    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".description-holder p").text

    student
  end

end
