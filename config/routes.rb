Rails.application.routes.draw do
  
  post '/dropzone/upload' => 'dropzone#upload', as: :upload_dropzone

end