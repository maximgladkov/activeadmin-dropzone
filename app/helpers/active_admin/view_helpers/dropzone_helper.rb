module ActiveAdmin::ViewHelpers::DropzoneHelper

  def render_mock_dropzone_files(dropzone_objects)
    dropzone_objects.map do |dropzone_object|
      { 
        id: dropzone_object.id, 
        name: dropzone_object.send(dropzone_object.class.dropzone_field(:title)),
        size: dropzone_object.send(dropzone_object.class.dropzone_field(:file_size)), 
        url: dropzone_object.send(dropzone_object.class.dropzone_field(:url))
      }
    end.map do |hash|
      hash.map{ |(k, v)| "#{ k }: '#{ v }'" }.join(',')
    end.map do |string|
      "{#{ string }}"
    end.join(', ').html_safe
  end
  
end