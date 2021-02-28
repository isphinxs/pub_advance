require "faker"

20.times do
    Author.create(name: Faker::Name.unique.name, password: Faker::Science.element, username: Faker::Space.galaxy)
    Book.create(title: Faker::Book.unique.title, advance: Faker::Number.within(range: 0..1000000), year_published: Faker::Number.number(digits: 4), author_id: Faker::Number.within(range: 1..21))
end
