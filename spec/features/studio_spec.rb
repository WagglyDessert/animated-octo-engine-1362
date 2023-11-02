require "rails_helper"

RSpec.describe Studio, type: :feature do
  before :each do 
    @studio1 = Studio.create(name: "Universal Studios", location: "Hollywood")
    @studio2 = Studio.create(name: "Nathan's Studios", location: "Denver")

    @movie1 = @studio1.movies.create(title: 'Toy Story', creation_year: '1995', genre: 'animation')
    @movie2 = @studio1.movies.create(title: 'Elephant Christmas', creation_year: '1997', genre: 'romance')
    @movie3 = @studio2.movies.create(title: 'Halloween Boy', creation_year: '2023', genre: 'comedy')
  end
  describe "studio index page" do
    it "shows name and location as well as movie title, year, and genre" do
    # User Story 1
    # As a user,
    # When I visit the studio index page,
    # Then I see all of the studios including name and location,
    # And under each studio I see all of the studio's movies
    # including the movie's title, creation year, and genre
      visit "/studios"

      within("#studio-#{@studio1.id}") do
        expect(page).to have_content(@studio1.name)
        expect(page).to have_content(@studio1.location)
        expect(page).to have_content(@movie1.title)
        expect(page).to have_content(@movie1.creation_year)
        expect(page).to have_content(@movie1.genre)
        expect(page).to have_content(@movie2.title)
        expect(page).to have_content(@movie2.creation_year)
        expect(page).to have_content(@movie2.genre)
      end

      within("#studio-#{@studio2.id}") do
        expect(page).to have_content(@studio2.name)
        expect(page).to have_content(@studio2.location)
        expect(page).to have_content(@movie3.title)
        expect(page).to have_content(@movie3.creation_year)
        expect(page).to have_content(@movie3.genre)
      end
    end
  end
end