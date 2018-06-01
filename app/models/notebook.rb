# frozen_string_literal: true

class Notebook < ApplicationRecord
  has_many :notes, dependent: :destroy
  validates_presence_of :title
end
