class Api::V1::BooksController < Api::V1::BaseController

  def search
    response = {}
    keyword = params[:keyword]

    limit = 10
    page = params[:page]
    total_pages = 1
    if keyword.blank?
      if page.blank?
        books = Book.only(:name, :short_desc, :publication_date, :genre)
      else
        books = Book.only(:name, :short_desc, :publication_date, :genre).paginate(:page => page, :per_page => limit)
        total_pages = books.total_pages
      end
    else
      logger.info { "---------> Book search :: Getting books for keyword : #{keyword}" }
      if page.blank?
        books = Book.only(:name, :short_desc, :publication_date, :genre).full_text_search(keyword)
      else
        books = Book.only(:name, :short_desc, :publication_date, :genre).full_text_search(keyword).paginate(:page => page, :per_page => limit)
        total_pages = books.total_pages
      end
    end
    response[:status] = 200
    response[:message] = 'Successfully fetched books'
    response[:pages] = total_pages
    response[:payload] = books    
    render json: response
  end
end
