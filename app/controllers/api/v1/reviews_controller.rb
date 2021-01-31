# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :load_book, only: :index
      before_action :load_review, only: %i[show update destroy]
      before_action :authenticate_with_token!, only: %i[create update destroy]

      def index
        @reviews = @book.reviews
        reviews_serializer = parse_json(@reviews)
        json_response('Books reviews', true, { reviews: reviews_serializer }, :ok)
      end

      def show
        review_serializer = parse_json(@review)
        json_response('Show a review', true, { eview: review_serializer }, :ok)
      end

      def create
        review = Review.new(review_params)
        review.user_id = current_user.id
        review.book_id = params[:book_id]

        if review.save
          review_serializer = parse_json(review)
          json_response('Created a review successfully.', true, { review: review_serializer }, :ok)
        else
          json_response('Failed to create a review.', false, {}, :unprocessable_entity)
        end
      end

      def update
        if correct_user(@review.user)
          if @review.update(review_params)
            review_serializer = parse_json(@review)
            json_response('Updated a review successfully.', true, { review: review_serializer }, :ok)
          else
            json_response('Failed to update a review.', false, {}, :unprocessable_entity)
          end
        else
          json_response("You dont't have permission to this action.", false, {}, :unauthorized)
        end
      end

      def destroy
        if correct_user(@review.user)
          if @review.destroy
            review_serializer = parse_json(@review)
            json_response('Deleted a review successfully.', true, {}, :ok)
          else
            json_response('Failed to delete a review.', false, {}, :unprocessable_entity)
          end
        else
          json_response("You dont't have permission to this action.", false, {}, :unauthorized)
        end
      end

      private

      def load_book
        @book = Book.find_by_id(params[:book_id])
        json_response('Could not find a book', false, {}, :not_found) unless @book.present?
      end

      def load_review
        @review = Review.find_by_id(params[:id])
        json_response('Could not find a review', false, {}, :not_found) unless @review.present?
      end

      def review_params
        params.require(:review).permit(:title, :content_rating, :recommend_rating)
      end
    end
  end
end
