Rails.application.routes.prepend do
  
  post '/dropzone/upload' => 'dropzone#upload', as: :upload_dropzone

end