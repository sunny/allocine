$:.unshift File.dirname(__FILE__)
require 'rubygems'
require 'open-uri'
require 'iconv'
require 'lib/allocine'
require 'lib/allocine_movie'
require 'lib/allocine_show'
MOVIE_SEARCH_URL = "http://www.allocine.fr/recherche/?motcle=%s&rub=1"
MOVIE_DETAIL_URL = "http://www.allocine.fr/film/fichefilm_gen_cfilm=%s.html"
SHOW_SEARCH_URL = "http://www.allocine.fr/recherche/?motcle=%s&rub=6"
SHOW_DETAIL_URL = "http://www.allocine.fr/series/ficheserie_gen_cserie=%s.html"
