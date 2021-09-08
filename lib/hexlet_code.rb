# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/serializers'
require_relative 'hexlet_code/configuration'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form_inputs'
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
    config.default_serializer.serialize(form_tag)
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end
end
