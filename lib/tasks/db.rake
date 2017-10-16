# Use 'rake db:dump_data' to run below task

namespace :db do
  desc "Task to populate data"
  task dump_data: :environment do
    puts "----> Populating initial data...."
    # Adding 1000 authors
    1000.times do
      author_name = Faker::Name.name
      author = Author.new({
        author_name: author_name,
        author_bio: Faker::Lorem.paragraph(10, true, 10),
        profile_pic: Faker::Avatar.image(author_name.parameterize.underscore),
        academics: Faker::Lorem.paragraph,
        awards: Faker::Lorem.paragraph
      })
      author.save
    end

    # Adding 5000 books
    5000.times do
      title = Faker::Book.title
      book = Book.new({
        name: title,
        short_desc: Faker::Lorem.sentence,
        long_desc: Faker::Lorem.paragraph(5, true, 5),
        chapter_index: Faker::Lorem.paragraph(5, true, 5),
        publication_date: Faker::Date.between(1.year.ago,  Date.today),
        genre: Book::GENRE.sample
      })

      # Assigning random authors for book
      rand(1..3).times do
        book.authors << Author.skip(rand(Author.count)).first
      end

      # Adding 5 reviews for each book
      5.times do
        review = Review.new({
          reviewer_name: Faker::Name.name,
          stars: rand(1..5),
          title: Faker::Name.title,
          review_desc: Faker::Matz.quote
        })
        book.reviews << review
        review.save
      end
      book.save
    end
  end

end
