require 'sinatra'
require 'sqlite3'
require 'haml'

get '/tiles/:zoom/:column/:row' do
  content_type 'image/png'
  
  # flip round the y coordinate for mapbox
  y = ((2**params[:zoom].to_f) - 1) - params[:row].to_f
  
  
  db = SQLite3::Database.new "data/wdpa_test_z5to8.mbtiles"
  rows = db.execute("select images.tile_data 
                     from map 
                     inner join images 
                     on (map.tile_id = images.tile_id) 
                     where zoom_level = #{params[:zoom]} AND 
                     tile_row = #{y} AND 
                     tile_column = #{params[:column]}")
  
  rows[0][0] unless rows.length == 0
end

get '/' do
  haml :index
end

