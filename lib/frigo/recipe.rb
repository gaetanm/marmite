module Frigo
  class Recipe
    SEARCH_URL = ROOT_URL + '/recettes/recherche.aspx?'
    P_INGREDIENT = 'aqt='
    P_TYPE = 'dt='

    attr_reader :name, :author, :picture, :link,
                :preparation_time, :cooking_time, :nbr_of_people,
                :detail, :steps, :ingredients

    class << self
      def find(ingredient, type = nil)
        ingredient = P_INGREDIENT + ingredient
        type = P_TYPE + type
        page = HTTParty.get(SEARCH_URL+ingredient+'&'+type)
        build_from_links(retrieve_link(Nokogiri::HTML(page)))
      end

      private

      def build_from_links(links)
        links.map { |link| Recipe.new(retrieve_data(link)) }
      end

      def retrieve_link(parsed_page)
        parsed_page.css('.recette_classique').map { |node| node.css('.m_titre_resultat a')[0][:href] }
      end

      def retrieve_data(link)
        data = {}
        page = HTTParty.get(ROOT_URL + link)
        pp = Nokogiri::HTML(page)
        data[:name] = pp.css('.main-title').text.strip
        data[:author] = pp.css('.recipe-author__name').text.strip
        data[:picture] = retrieve_picture(pp)
        data[:link] = link
        data[:preparation_time] = pp.css('.recipe-infos__timmings__preparation').css('.recipe-infos__timmings__value').text.strip
        data[:cooking_time] = pp.css('.recipe-infos__timmings__cooking').css('.recipe-infos__timmings__value').text.strip
        data[:nbr_of_people] = pp.css('.recipe-infos__quantity__value').text
        data[:steps] = pp.css('.recipe-preparation__list__item').map(&:text)
        data[:ingredients] = pp.css('.recipe-ingredients__list__item').map(&:text).map(&:strip)
        data
      end

      def retrieve_picture(parsed_page)
        node = parsed_page.css('#af-diapo-desktop-0_img')
        node[0][:src] if node && node[0]
      end
    end

    def initialize(params = {})
      @name        = params[:name]
      @author      = params[:author]
      @picture     = params[:picture]
      @link        = params[:link]
      @preparation_time = params[:preparation_time]
      @cooking_time = params[:cooking_time]
      @nbr_of_people = params[:nbr_of_people]
      @steps = params[:steps]
      @ingredients = params[:ingredients]
    end
  end
end