# frozen_string_literal: true

class Review < ApplicationRecord
  before_save :calculate_averege_rating
  belongs_to :user
  belongs_to :book

  counter_culture :book

  def calculate_averege_rating
    self.average_rating = ((content_rating.to_f + recommend_rating.to_f) / 2).round(1)
  end
end
