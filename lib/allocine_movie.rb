class AllocineMovie
  
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
    str = open(MOVIE_DETAIL_URL.gsub('__ID__', id)).read.to_s
    @data = Iconv.conv('UTF-8', 'ISO-8859-1', str)
    @parsed = {}
    regexps.each do |reg|
      print "#{reg[0]}: " if debug
      r = @data.scan Regexp.new(reg[1], Regexp::MULTILINE)
      r = r.first.to_s.strip
      r.gsub!(/<.*?>/, '')
      r.gsub!(/<\/.*?>/, '')
      @parsed.merge!({reg[0].to_sym => "#{r}"})
      print "#{r}\n" if debug
    end
    @parsed.each do |k,v|
      self.instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
    end
    @parsed = ""
    @data = ""
  end
end