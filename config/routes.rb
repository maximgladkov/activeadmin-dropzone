# temporary fix double route error
unless defined?(Rails.application.routes.url_helpers.upload_dropzone_path)
  Rails.application.routes.draw do
    
    post '/dropzone/upload' => 'dropzone#upload', as: :upload_dropzone

  end
end