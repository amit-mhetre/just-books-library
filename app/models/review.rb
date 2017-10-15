class Review
  include Mongoid::Document
  field :reviewer_name, type: String
  field :stars, type: String
  field :title, type: String
  field :review_desc, type: String

  belongs_to  :book
end
