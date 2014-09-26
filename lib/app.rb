require 'polygon'
require 'helpers'

class App < Polygon::Base
  helpers Helpers

  SONGS = (Path.dir.parent/("content/static/mp3")).glob("*.mp3").map{|f|
    f.basename.rm_ext.to_s
  }

  get '/sitemap.xml' do
    content_type "application/xml"
    wlang :sitemap, :locals => sitemap_locals, :layout => false
  end

  get "/" do
    wlang :index, :locals => index_locals.merge(song: "cover", audio: false)
  end

  SONGS.each do |song|
    get "/#{song}" do
      wlang :index, :locals => index_locals.merge(song: song, audio: true)
    end
  end

end
