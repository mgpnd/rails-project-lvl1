# frozen_string_literal: true

module HexletCode
  module FormInputs
    class Select < Base
      attr_reader :collection

      def initialize(*args, **kwargs)
        super
        @collection = attributes[:collection] || []
        @attributes = @attributes.except(:collection, :value)
      end

      def build_input
        Tag.new('select', name: name, options: { multiline: true }, **attributes) do
          collection.map do |opt_value|
            option_attrs = { value: opt_value }
            option_attrs[:selected] = true if opt_value == value
            Tag.new('option', option_attrs) { opt_value }
          end
        end
      end
    end
  end
end
