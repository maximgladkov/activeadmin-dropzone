module Activeadmin
  module Dropzone
    extend ActiveSupport::Concern

    module ClassMethods
      def dropzone(association_name)
        class_eval %Q(
          def self.dropzone_#{ association_name }_class
            self.reflect_on_association(:#{ association_name }).class_name.constantize
          end

          def #{ association_name }_attributes=(attributes)
            original_collection = self.#{ association_name }.to_a

            ActiveRecord::Base.transaction do
              self.#{ association_name } = self.class.dropzone_#{ association_name }_class.find(attributes.select{ |id, hash| !id.blank? and id != '-1' }.map{ |id, hash| id.to_i })

              self.#{ association_name }.each do |dropzone_object|
                attribute = attributes[dropzone_object.id.to_s]
                changes = {}

                title_field = self.class.dropzone_#{ association_name }_class.dropzone_field(:title)
                if dropzone_object.respond_to?(title_field) and dropzone_object.send(title_field) != attribute['title']
                  changes[title_field] = attribute['title']
                end

                position_field = self.class.dropzone_#{ association_name }_class.dropzone_field(:position)
                if dropzone_object.respond_to?(position_field) and dropzone_object.send(position_field) != attribute['position'].to_i
                  changes[position_field] = attribute['position']
                end

                unless changes.empty?
                  dropzone_object.update_attributes changes
                end
              end

              self.update_attribute :#{ association_name }_count, self.#{ association_name }.count if self.respond_to?(:#{ association_name }_count)

              (original_collection - self.#{ association_name }).each do |object|
                object.destroy
              end
            end
          end

          def self.dropzone_#{ association_name }_field(key)
            dropzone_#{ association_name }_class.dropzone_field(key)
          end

          def self.dropzone_#{ association_name }_field?(key)
            dropzone_#{ association_name }_class.dropzone_field?(key)
          end
        )
      end

      def dropzone_item(options = {})
        options = {
          title: :title,
          position: :position,
          data: :data,
          file_size: :data_file_size,
          url: :data_url
        }.deep_merge(options)

        class_eval %Q(
          def self.dropzone_field(key)
            #{ options }[key.to_sym]
          end

          def self.dropzone_field?(key)
            #{ options }.keys.include? key.to_sym
          end

          def data_url
            #{ options[:data] }.url
          end

          def as_json(options = { })
            super(options).merge({
              url: data_url
            })
          end
        )
      end
    end
  end
end

ActiveRecord::Base.send :include, Activeadmin::Dropzone