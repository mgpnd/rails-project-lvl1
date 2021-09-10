# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def build(object, url: nil)
      (raise Error, 'Missing form content block') unless block_given?

      action = url.nil? ? '#' : url

      form = Form.new(object)
      yield form

      form_tag = Tag.new(
        'form',
        action: action,
        method: 'post',
        options: { multiline: true }
      )
      form_tag.content = form.output
      form_tag
    end
  end
end
