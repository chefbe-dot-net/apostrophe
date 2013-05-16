require 'polygon'
require 'helpers'

class App < Polygon::Base
  helpers Helpers

  get '/sitemap.xml' do
    content_type "application/xml"
    wlang :sitemap, :locals => sitemap_locals, :layout => false
  end

  get "/" do
    wlang :index, :locals => index_locals.merge(song: "cover", audio: false)
  end

  get %r{^/(.*)} do |song|
    wlang :index, :locals => index_locals.merge(song: song, audio: true)
  end

end
