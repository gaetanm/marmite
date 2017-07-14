require 'frigo/version'
require 'httparty'
require 'nokogiri'

module Frigo
  ROOT_URL = 'http://www.marmiton.org'
  DISH_TYPES = %w[entree platprincipal dessert amusegueule boisson sauce]
end

require 'frigo/recipe'
