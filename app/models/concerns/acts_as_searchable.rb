
#encoding: utf-8
module ActsAsSearchable
  extend ActiveSupport::Concern

  included do

    def searchable_option(key)
      searchable_option_key = self.class.searchable_options[key.to_sym]
      if searchable_option_key
        if searchable_option_key.is_a? Proc
          option = searchable_option_key.(self)
        else
          # Check for static options (like icon)
          if self.class.searchable_static_options.include?(key.to_sym)
            option = searchable_option_key
          else
            option = send(searchable_option_key)
          end
        end
      end
      option
    end

    def search_label
      searchable_option(:label_method)
    end

  end


    module ClassMethods

      @@default_searchable_options = {
        label_method: nil
      }

      # Defines options that will not be sent to instance using ruby send method but used as static variable
      @@searchable_static_options = []

      @@searchable_required_options = [:label_method]

      def searchable(options = {})

        # create a reader on the class to access the options from the searchable instance
        class << self; attr_reader :searchable_options; end

        if missing_options = (@@searchable_required_options - options.keys) and missing_options.present?
          raise "Missing Options #{missing_options} ! Please define those options to use this concern !"
        end

        @searchable_options = @@default_searchable_options.merge options

        if @searchable_options[:trigger]
          send(@searchable_options[:trigger], :notify!)
        end
      end

      def searchable_static_options
        @@searchable_static_options
      end
    end
end
