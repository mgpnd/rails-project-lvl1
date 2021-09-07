# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/serializers'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form'

module HexletCode
  class Error < StandardError; end

  def self.form_for(object, url: nil)
    form = Form.new(object)
    yield form

    action = url.nil? ? '#' : url

    form_tag = Tag.new(
      'form',
      action: action,
      method: 'post',
      options: { multiline: true }
    )
    form_tag.content = form.output
    Serializers::Html.serialize(form_tag)
  end
end
