class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def order_by_age
    actors.order(age: :asc)
  end

  def avg_age
    actors.average(:age).to_f.round(2)
  end

  def self.search(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end
end
