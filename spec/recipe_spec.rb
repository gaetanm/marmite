require "spec_helper"

RSpec.describe Frigo::Recipe do
  describe '.find' do
    it 'returns 10 recipes' do
      recipes = Frigo::Recipe.find('abricot', 'entree')
      expect(recipes.count).to eql(10)
    end

    it 'fills the returned recipes' do
      recipe = Frigo::Recipe.find('fraise', 'dessert').first
      expect(recipe).to have_attributes(
        name: 'Tiramisu aux fraises',
        author: 'Anonyme',
        picture: 'https://image.afcdn.com/recipe/20160404/2834_w397h246c1cx1500cy1000.jpg',
        link: '/recettes/recette_tiramisu-aux-fraises_14039.aspx',
        preparation_time: '20 min',
        cooking_time: '',
        nbr_of_people: '4',
        steps: include("Préparer 2 h à l'avance."),
        ingredients: include('250 g de mascarpone'))
    end
  end
end