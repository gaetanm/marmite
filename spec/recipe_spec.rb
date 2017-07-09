require "spec_helper"

RSpec.describe Frigo::Recipe do
  describe 'search' do
    it 'returns 10 recipes' do
      recipes = Frigo::Recipe.search('fraise', 'dessert')
      expect(recipes.count).to eql(10)
    end
  end
end