class Allocine  
  def self.find_movie(search)
    search = search.gsub(' ', '+')
    @data = open(MOVIE_SEARCH_URL.gsub('__SEARCH__', search)).read.to_s
    @films = {}
    while @data =~ /<a href="\/film\/fichefilm_gen_cfilm=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      @data.gsub!("<a href=\"/film/fichefilm_gen_cfilm=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      @films.merge!({id, name})
    end
    return @films
  end
  
  def self.find_show(search)
    search = search.gsub(' ', '+')
    @data = open(SHOW_SEARCH_URL.gsub('__SEARCH__', search)).read.to_s
    @shows = {}
    while @data =~ /<a href="\/series\/ficheserie_gen_cserie=(\d+).html" class="link(\d+)">(.*?)<\/a>/i
      id, klass, name = $1, $2, $3
      @data.gsub!("<a href=\"/series/ficheserie_gen_cserie=#{id}.html\" class=\"link#{klass}\">#{name}</a>", "")
      name.gsub!(/<(.+?)>/,'')
      @shows.merge!({id, name})
    end
    return @shows
  end
end