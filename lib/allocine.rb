class Allocine  
  def self.find_movie(search)
    search = search.gsub(' ', '+')
    str = open(MOVIE_SEARCH_URL % search).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    films = {}
    while data =~ /<a href="\/film\/fichefilm_gen_cfilm=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      data.gsub!("<a href=\"/film/fichefilm_gen_cfilm=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      films.merge!({id, name})
    end
    films
  end
  
  def self.find_show(search)
    search = search.gsub(' ', '+')
    str = open(SHOW_SEARCH_URL % search).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    shows = {}
    while data =~ /<a href="\/series\/ficheserie_gen_cserie=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      data.gsub!("<a href=\"/series/ficheserie_gen_cserie=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      shows.merge!({id, name})
    end
    shows
  end
  
  def self.lucky_movie(search)
    results = self.find_movie(search)
    AllocineMovie.new(results.keys.first)
  end
  
  def self.lucky_show(search)
    results = self.find_show(search)
    AllocineShow.new(results.keys.first)
  end
end