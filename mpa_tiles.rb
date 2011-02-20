require 'sinatra'
require 'sqlite3'



get '/:zoom/:row/:column' do
  content_type 'image/png'
  db = SQLite3::Database.new "data/wdpa_test_z5to8.mbtiles"
  # Find a few rows
  
  
  rows = db.execute("select images.tile_data 
                     from map 
                     inner join images 
                     on (map.tile_id = images.tile_id) 
                     where zoom_level = #{params[:zoom]} AND 
                     tile_row = #{params[:row]} AND 
                     tile_column = #{params[:column]}")
  
  rows[0][0]
  
end
