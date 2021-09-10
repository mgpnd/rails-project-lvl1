# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :object, :output

    def initialize(object)
      @object = object
      @output = []
    end

    def input(name, options = {})
      value = object.public_send(name)
      output.concat(
        FormInputs.input_for(
          options[:as],
          name: name,
          value: value,
          **options.except(:as)
        ).build
      )
    end

    def submit(value = 'Save')
      output << Tag.new('input', type: 'submit', name: 'commit', value: value)
    end
  end
end
