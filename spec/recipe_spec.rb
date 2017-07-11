require "spec_helper"

RSpec.describe Frigo::Recipe do
  describe '.find' do
    it 'returns 10 recipes' do
      recipes = Frigo::Recipe.find('fraise', 'dessert')
      expect(recipes.count).to eql(10)
    end
  end
end