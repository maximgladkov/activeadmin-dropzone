class DropzoneInput 
  include Formtastic::Inputs::Base

  def to_html
    template.render 'dropzone', object: object, options: options
  end

end