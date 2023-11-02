require "rails_helper"

RSpec.describe Movie, type: :model do
  describe "relationships" do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many(:actors).through(:movie_actors)}
  end

  describe "instance methods" do
    before :each do 
      @studio1 = Studio.create(name: "Universal Studios", location: "Hollywood")
      @movie1 = @studio1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation')
      @actor1 = Actor.create(name: "Nathan Turing", age: 31)
      @actor2 = Actor.create(name: "Thomas Hanks", age: 69)
      @actor3 = Actor.create(name: "Blueberry Bingle", age: 118)
      @actor4 = Actor.create(name: "NomNom", age: 0)
      MovieActor.create(movie_id: @movie1.id, actor_id: @actor1.id)
      MovieActor.create(movie_id: @movie1.id, actor_id: @actor2.id)
      MovieActor.create(movie_id: @movie1.id, actor_id: @actor3.id)
      MovieActor.create(movie_id: @movie1.id, actor_id: @actor4.id)
    end
    it "actors sorted by age retruns actor for a given movie youngest to oldest" do
    expect(@movie1.order_by_age).to eq([@actor4, @actor1, @actor2, @actor3])
    end
    it "average age will return avg calculation for all the actors in a movie" do
      expect(@movie1.avg_age).to eq(54.5)
    end
  end
end
