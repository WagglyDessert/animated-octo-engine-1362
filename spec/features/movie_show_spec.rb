require "rails_helper"

RSpec.describe Movie, type: :feature do
  before :each do 
    @studio1 = Studio.create(name: "Universal Studios", location: "Hollywood")
    @studio2 = Studio.create(name: "Nathan's Studios", location: "Denver")

    @movie1 = @studio1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation')
    @movie2 = @studio1.movies.create(title: 'Elephant Christmas', creation_year: '1997', genre: 'romance')
    @movie3 = @studio2.movies.create(title: 'Halloween Boy', creation_year: '2023', genre: 'comedy')

    @actor1 = Actor.create(name: "Nathan Turing", age: 31)
    @actor2 = Actor.create(name: "Thomas Hanks", age: 69)
    @actor3 = Actor.create(name: "Blueberry Bingle", age: 118)
    @actor4 = Actor.create(name: "NomNom", age: 0)

    MovieActor.create(movie_id: @movie3.id, actor_id: @actor1.id)
    MovieActor.create(movie_id: @movie1.id, actor_id: @actor1.id)
    MovieActor.create(movie_id: @movie2.id, actor_id: @actor1.id)
    MovieActor.create(movie_id: @movie3.id, actor_id: @actor2.id)
    MovieActor.create(movie_id: @movie1.id, actor_id: @actor2.id)
    MovieActor.create(movie_id: @movie3.id, actor_id: @actor3.id)
  end
  describe "movie show page" do
    it "shows movie title, year, and genre" do
    # Story 2 - Movie Show
    # As a user,
    # When I visit a movie's show page.
    # I see the movie's title, creation year, and genre,
    # and a list of all its actors from youngest to oldest.
    # And I see the average age of all of the movie's actors
      visit "/movies/#{@movie3.id}"

      within("#movie-details") do
        expect(page).to have_content(@movie3.title)
        expect(page).to have_content(@movie3.creation_year)
        expect(page).to have_content(@movie3.genre)
      end

    end
    it "has list of actors (name and age) ordered from youngest to oldest" do
      visit "/movies/#{@movie3.id}"

      expect(page).to have_content(@actor1.name)
      expect(page).to have_content(@actor2.name)
      expect(page).to have_content(@actor3.name)

      expect(@actor1.name).to appear_before(@actor2.name)
      expect(@actor2.name).to appear_before(@actor3.name)
      expect(@actor1.name).to appear_before(@actor3.name)
    end
    it "has the average age of all actors in the movie" do
      visit "/movies/#{@movie3.id}"

      expect(page).to have_content(72.67)
    end
  end
  describe "movie show page" do
    it "has form to add actor to this movie" do
    # Story 3
    # Add an Actor to a Movie
    # As a user,
    # When I visit a movie show page,
    visit "/movies/#{@movie3.id}"
    # I do not see any actors listed that are not part of the movie
    expect(page).to_not have_content(@actor4.name)
    # And I see a form to add an actor to this movie
    expect(page).to have_field(:actor_id)
    # When I fill in the form with the ID of an actor that exists in the database
    fill_in :actor_id, with: @actor4.id
    # And I click submit
    click_button("submit")
    # Then I am redirected back to that movie's show page
    expect(current_path).to eq "/movies/#{@movie3.id}"
    # And I see the actor's name is now listed
    expect(page).to have_content(@actor4.name)
    # (You do not have to test for a sad path, for example if the id submitted is not an existing actor)
    end
  end
end