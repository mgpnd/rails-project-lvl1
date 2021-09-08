# frozen_string_literal: true

module HexletCode
  module FormInputs
    class Input < Base
      def build_input
        Tag.new('input', type: 'text', name: name, value: value, **attributes)
      end
    end
  end
end
