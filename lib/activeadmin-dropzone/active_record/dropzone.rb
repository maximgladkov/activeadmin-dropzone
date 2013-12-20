module Activeadmin
  module Dropzone
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def dropzone(association_name)
        class_eval %Q(
          def #{ association_name }_attributes=(attributes)
            reflection = self.class.reflect_on_association(:#{ association_name })

            p "self.class.reflect_on_association(:#{ association_name })"

            self.#{ association_name } = reflection.class_name.constantize.find(attributes.select{ |id, hash| !id.blank? and id != '-1' }.map{ |id, hash| id.to_i })

            self.#{ association_name }.each do |dropzone_object|
              if dropzone_object.title != attributes[dropzone_object.id.to_s]['title'] or dropzone_object.position != attributes[dropzone_object.id.to_s]['position'].to_i
                dropzone_object.update_attributes title: attributes[dropzone_object.id.to_s]['title'], position: attributes[dropzone_object.id.to_s]['position']
              end
            end

            self.update_attribute :#{ association_name }_count, self.#{ association_name }.size
          end
        )

        class_eval do
          def self.dropzone_title_field
            :title
          end

          def self.dropzone_position_field
            :position
          end

          def self.dropzone_field
            :image
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Activeadmin::Dropzone