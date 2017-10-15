class Author
  include Mongoid::Document
  field :author_name, type: String
  field :author_bio, type: String
  field :profile_pic, type: String
  field :academics, type: String
  field :awards, type: String

  has_and_belongs_to_many  :books
end
