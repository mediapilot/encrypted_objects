require "encrypted_objects/version"
require "base64"
require "multi_json"

module EncryptedObjects
  # Exceptions
  class BadString < RuntimeError; end

  extend self

  def b64_decode(string)
    padding_length = string.length % 4
    string = string.tr('~', '/')
    Base64.decode64(string + '=' * padding_length)
  end

  def b64_encode(string)
    Base64.encode64(string).tr("\n=",'')
  end

  def json_b64_decode(string)
    json_decode(b64_decode(string))
  end

  def json_b64_encode(object)
    b64_encode(json_encode(object))
  end

  def json_decode(string = "")
    raise BadString, "can't decode blank string" if string.empty?
    MultiJson.decode(string, symbolize_keys: true)
  rescue MultiJson::DecodeError => e
    raise BadString, "couldn't json decode string - got #{e}"
  end

  def json_encode(object)
    MultiJson.encode(object)
  end
end
