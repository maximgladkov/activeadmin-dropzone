module ActiveAdmin::ViewsHelper

  def render_mock_dropzone_files(dropzone_objects)
    unless dropzone_objects.empty?
      dropzone_objects.map do |dropzone_object|
        "{ id: #{ dropzone_object.id }, name: '#{ dropzone_object.send dropzone_object.class.dropzone_name_field }', size: #{ dropzone_object.send dropzone_object.class.dropzone_file_size_field }, url: '#{ dropzone_object.send dropzone_object.class.dropzone_url_field }' }"
      end.join(', ').html_safe
    end
  end
  
end