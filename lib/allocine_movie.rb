class AllocineMovie
  attr_accessor :title, :directors, :nat, :genres, :out_date, :duree, :production_date, :original_title, :actors, :synopsis, :image, :interdit

  def initialize(id, debug=false)
    regexps = {
      :title => '<title>(.*?)<\/title>',
      :directors => '<h4>Réalisé par <a .*?>(.*?)<\/a><\/h4>',
      :nat => '<h4>Film (.*?).&nbsp;</h4>',
      :genres => '<h4>Genre : (.*?)</h4>',
      :out_date => '<h4>Date de sortie : <b>(.*?)</b>',
      :duree => '<h4>Dur\ée : (.*?).&nbsp;</h4>',
      :production_date => '<h4>Année de production : (.*?)</h4>',
      :original_title => '<h4>Titre original : <i>(.*?)</i></h4>',
      :actors => '<h4>Avec (.*?) &nbsp;&nbsp;',
      :synopsis => '<td valign="top" style="padding:10 0 0 0"><div align="justify"><h4>(.*?)</h4>',
      :image => '<td valign="top" width="120".*?img src="(.*?)" border="0" alt="" class="affichette" />',
      :interdit => '<h4 style="color: #D20000;">Interdit(.*?)</h4>'
    }
    str = open(MOVIE_DETAIL_URL % id).read.to_s
    data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    regexps.each do |reg|
      print "#{reg[0]}: " if debug
      r = data.scan Regexp.new(reg[1], Regexp::MULTILINE)
      r = r.first.to_s.strip
      r.gsub!(/<.*?>/, '')
      r.gsub!(/<\/.*?>/, '')
      self.instance_variable_set("@#{reg[0]}", r)
      print "#{r}\n" if debug
    end
  end
end