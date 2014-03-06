class DropzoneController < ApplicationController
  
  def upload
    dropzone_class = params[:dropzone_class].constantize
    dropzone_object = dropzone_class.new
    dropzone_object.send "#{ dropzone_class.dropzone_field(:container_type) }=", params[:dropzonable_class] if dropzone_class.dropzone_field?(:container_type)
    dropzone_object.send "#{ dropzone_class.dropzone_field(:container_id) }=", params[:dropzonable_id] if dropzone_class.dropzone_field?(:container_id)
    dropzone_object.send "#{ dropzone_class.dropzone_field(:data) }=", params[:file]

    if dropzone_object.save
      render json: dropzone_object.to_json
    else
      head :error and return
    end
  end

end