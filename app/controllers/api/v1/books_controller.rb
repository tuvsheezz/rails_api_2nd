class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show
  before_action :authenticate_with_token!, only: [:index, :show]

  def index
    @books = Book.all.includes([:reviews])
    books_serializers = parse_json(@books)
    json_response("Got all books successfully.", true, {books: books_serializers}, :ok)
  end

  def show
    book_serializers = parse_json(@book)
    json_response("Got a book successfully.", true, {book: book_serializers}, :ok)
  end

  private
  def load_book
    @book = Book.find_by_id(params[:id])
    unless @book.present?
      json_response("Could not get book.", false, {}, :not_found)
    end
  end
end
