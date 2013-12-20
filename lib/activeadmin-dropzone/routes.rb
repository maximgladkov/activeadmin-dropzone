Activeadmin::Dropzone::Engine.routes do
  
  post '/dropzone/upload' => 'dropzone#upload', as: :upload_dropzone

end