class Book
  include Mongoid::Document

  GENRE = ["Science fiction", "Satire", "Drama", "Action and Adventure", "Romance", "Mystery", "Horror", "Self help", "Fantasy"]

  field :name, type: String
  field :short_desc, type: String
  field :long_desc, type: String
  field :chapter_index, type: String
  field :publication_date, type: Date
  field :genre, type: String

  has_and_belongs_to_many  :authors
  has_many  :reviews
end
