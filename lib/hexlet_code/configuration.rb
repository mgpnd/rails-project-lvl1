# frozen_string_literal: true

module HexletCode
  class Configuration
    attr_accessor :serializer, :form_builder

    def initialize
      @serializer = Serializers::Html.new
      @form_builder = FormBuilder.new
    end
  end
end
