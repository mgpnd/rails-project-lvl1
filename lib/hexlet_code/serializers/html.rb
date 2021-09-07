# frozen_string_literal: true

module HexletCode
  module Serializers
    module Html
      def self.serialize(tag_instance)
        output = tag_opening(tag_instance.tag)
        output += tag_attributes(tag_instance)
        return output + tag_self_close if tag_instance.content.empty?

        output +=
          if tag_instance.options[:multiline]
            tag_multiline_content(tag_instance.content)
          else
            tag_content(tag_instance.content)
          end

        output += tag_close(tag_instance.tag)
        output
      end

      def self.tag_opening(tag)
        "<#{tag}"
      end

      def self.tag_attributes(tag_instance)
        tag_instance
          .attributes
          .reduce('') { |output, (name, value)| output + tag_attribute(name, value) }
      end

      def self.tag_attribute(name, value)
        return " #{name}" if value == true

        " #{name}=\"#{value}\""
      end

      def self.tag_multiline_content(content)
        output = '>'
        output += "\n"

        content.each_with_index do |child, index|
          output +=
            case child
            when HexletCode::Tag
              Serializers::Html.serialize(child)
                               .split("\n")
                               .map { |line| "  #{line}" }
                               .join("\n")
            else
              child
            end

          output += "\n" if (index + 1) < content.size
        end

        output += "\n"
        output
      end

      def self.tag_content(content)
        output = '>'

        content.each do |child|
          output +=
            case child
            when HexletCode::Tag
              Serializers::Html.serialize(child)
            else
              child
            end
        end

        output
      end

      def self.tag_close(tag)
        "</#{tag}>"
      end

      def self.tag_self_close
        ' />'
      end
    end
  end
end
