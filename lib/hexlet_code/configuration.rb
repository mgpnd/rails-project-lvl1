# frozen_string_literal: true

module HexletCode
  class Configuration
    attr_accessor :default_serializer

    def initialize
      @default_serializer = HexletCode::Serializers::Html.new
    end
  end
end
