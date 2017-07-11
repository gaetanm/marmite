module Frigo
  class Recipe
    SEARCH_URL = ROOT_URL + '/recettes/recherche.aspx?'
    P_INGREDIENT = 'aqt='
    P_TYPE = 'dt='

    attr_reader :name, :description, :picture, :link

    class << self
      def find(ingredient, type = nil)
        ingredient = P_INGREDIENT + ingredient
        type = P_TYPE + type
        page = HTTParty.get(SEARCH_URL+ingredient+'&'+type)
        build_recipes(Nokogiri::HTML(page))
      end

      private

      def build_recipes(parsed_page)
        recipes = []
        parsed_page.css('.recette_classique').each do |recipe|
          name = recipe.css('.m_titre_resultat a')[0]['title']
          link = recipe.css('.m_titre_resultat a')[0]['href']
          recipes << Recipe.new(name, nil, nil, link)
        end
        recipes
      end
    end

    def initialize(name, description, picture, link)
      @name        = name
      @description = description
      @picture     = picture
      @link        = link
    end
  end
end