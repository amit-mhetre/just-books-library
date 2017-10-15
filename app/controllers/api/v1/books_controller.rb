class Api::V1::BooksController < Api::V1::BaseController

  def search
    response = {}
    keyword = params[:keyword]

    if keyword.blank?
      books = Book.only(:name, :short_desc, :publication_date, :genre)
    else
      logger.info { "---------> Book search :: Getting books for keyword : #{keyword}" }
      books = Book.only(:name, :short_desc, :publication_date, :genre).full_text_search(keyword)
    end
    response[:status] = 200
    response[:message] = 'Successfully fetched books'
    response[:payload] = books
    render json: response
  end
end
