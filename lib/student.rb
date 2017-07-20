class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    #
    # student_hash.each do |k,v|
    #   instance_variable_set("@#{k}", v) unless v.nil?
    # end
    @@all.push(self)
  end

  def self.create_from_collection(students_array)
    # The #add_student_attributes method should iterate over the given hash and
    # use metaprogramming to dynamically assign the student attributes and
    # values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
    # Important: The return value of this method should be the student itself. Use the self keyword.
    students_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
