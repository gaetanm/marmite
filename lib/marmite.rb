require 'marmite/version'
require 'httparty'
require 'nokogiri'

module Marmite
  ROOT_URL = 'http://www.marmiton.org'
  DISH_TYPES = %w[entree platprincipal dessert amusegueule boisson sauce]
end

require 'marmite/recipe'
