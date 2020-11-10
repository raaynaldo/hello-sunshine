# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'pry'

Student.destroy_all
Course.destroy_all
Teacher.destroy_all
Company.destroy_all
CourseRegistration.destroy_all
CompanyAdmin.destroy_all

puts "Students"

10.times do 
        Student.create(name: Faker::Name.unique.name,
                       username: Faker::Music::RockBand.name,
                       email: Faker::Internet.email,
                       password: '123456')

end

puts 'Companies'
#binding.pry
little_rockers = Company.create(name:'Little Rockers', description: "Making big and little shake their sillies out till they can't no more!", picture: 'https://images.unsplash.com/photo-1602863211757-cfe6454947fe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60')
silly_sunflowers = Company.create(name:'Silly Sunflowers', description: "Family Fun Music and Dance Class Company! Our offerings include Mommy and Me classes, Ballerina for Little Tikes, and modern improv dance for the whole Fam!", picture: 'https://images.unsplash.com/photo-1502781252888-9143ba7f074e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60')
jam_with_sam = Company.create(name:'Jam with Sam', description: "We are the wiggle monsters here to make you dance and sing the Abcs until the sunsets! Lets jam!", picture: 'https://images.unsplash.com/photo-1527236102507-6e5ac2692925?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60')


puts 'Company Admins'

companies = [little_rockers, silly_sunflowers, jam_with_sam]

companies.each do |company|
          CompanyAdmin.create(name: company.name,
                              username: company.name ,
                              password: '123456',
                              email: Faker::Internet.email,
                              company_id: company.id )
end





puts "Teachers"

5.times do 
     Teacher.create(name: Faker::Name.unique.name,
                     company_id: Company.all.sample.id,
                     specialty: ['music', 'dance', 'joybringing'].sample,
                     hobbies: ['songwriting', 'ballet', 'magic tricks', 'dancing like a silly monster'].sample,
                     website_link: ['https://laurieberkner.com/', 'https://raffinews.com/', 'https://www.joanieleeds.com/'].sample,
                     picture: ['https://images.unsplash.com/photo-1578774296842-c45e472b3028?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60',
                          'https://images.unsplash.com/photo-1554727242-741c14fa561c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 
                          'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 
                          'https://images.unsplash.com/photo-1591208333284-825682219525?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60', 
                          'https://images.unsplash.com/photo-1595929287357-74f1d41d5a5e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=60'].sample,
                     username: Faker::Music::RockBand.name,
                     email: Faker::Internet.email,
                     password: '123456')

     end

puts "Courses"

5.times do
     Course.create(title: ['Living on Sunshine sillies', 'Rock and Roll Babies', 'Sams Jam for Real', "Tutu Toddlers", "Caterpillar roll, rock, and ramble"].sample ,
                   course_type: ['music', 'dancing'].sample,
                   date: DateTime.now,
                   price: 10,
                   min_age: 2,
                   max_age: 7,
                   teacher_id: Teacher.all.sample.id,
                   location: ['zoom room', 'private zoom room', 'live'].sample,
                   picture: ['https://images.unsplash.com/photo-1504484656217-38f8ffc617f9?ixlib=rb-1.2.1&ixid=eyJhcHBfaW', 'https://images.unsplash.com/photo-1577877777751-3f1ec20a0715?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1215&q=80', 'https://thumbs.dreamstime.com/b/table-top-view-decoration-kid-toys-develop-background-concept-flat-lay-accessories-baby-to-play-items-child-modern-155761164.jpg'].sample,
                   max_student: 15)
end



puts "course Registrations "


10.times do
        CourseRegistration.create(student_id: Student.all.sample.id,
                                  course_id: Course.all.sample.id)
end
