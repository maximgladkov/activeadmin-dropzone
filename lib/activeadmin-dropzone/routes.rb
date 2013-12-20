Activeadmin::Dropzone::Engine.routes.draw do |map|
  
  post '/dropzone/upload' => 'dropzone#upload', as: :upload_dropzone

end