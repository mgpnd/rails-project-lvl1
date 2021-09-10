# frozen_string_literal: true

module HexletCode
  module FormInputs
    class Textarea < Base
      def initialize(*args, **kwargs)
        super
        @attributes = @attributes.except(:value)
      end

      def build_input
        Tag.new(
          'textarea',
          name: name,
          cols: cols,
          rows: rows,
          **attributes
        ) { value }
      end

      private

      def cols
        @cols ||= attributes[:cols] || 20
      end

      def rows
        @rows ||= attributes[:rows] || 40
      end
    end
  end
end
