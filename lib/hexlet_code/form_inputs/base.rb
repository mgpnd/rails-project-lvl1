# frozen_string_literal: true

module HexletCode
  module FormInputs
    class Base
      attr_reader :name, :label, :value, :attributes

      def initialize(name, label: nil, **attributes)
        @name = name
        @label = label
        @value = attributes[:value]
        @attributes = attributes
      end

      def build
        output = [build_label]
        output << build_input
        output
      end

      def build_label
        label_content = label || humanize_name(name)
        Tag.new('label', for: name) { label_content }
      end

      def build_input
        raise NotImplementedError
      end

      private

      def humanize_name(name)
        result = name.to_s.dup
        result.gsub!(/_id$/, '')
        result.gsub!(/_/, ' ')
        result.gsub!(/^\w/) { Regexp.last_match(0).upcase }
      end
    end
  end
end
