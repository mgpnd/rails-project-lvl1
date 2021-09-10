# frozen_string_literal: true

module HexletCode
  # @content is a mixed array of strings and Tag instances
  class Tag
    attr_accessor :tag, :attributes, :options, :content

    def self.build(tag, attributes = {}, &block)
      tag = new(tag, attributes, &block)
      HexletCode.config.serializer.serialize(tag)
    end

    def initialize(tag, attributes = {})
      @tag = tag
      @options = attributes[:options] || {}
      @attributes = attributes.compact.except(:options)
      @content = []

      return unless block_given?

      block_content = yield

      if block_content.is_a?(Array)
        @content += block_content
      else
        @content << block_content
      end
    end
  end
end
