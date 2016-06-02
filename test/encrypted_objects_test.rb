require 'test_helper'

class EncryptedObjectsTest < Minitest::Spec
  include EncryptedObjects

  describe "base 64 encoding/decoding" do
    [
        'a',
        'sdhflasd',
        '/2010/03/01/hello.png',
        '//..',
        'whats/up.egg.frog',
        '£ñçùí;',
        '~'
    ].each do |string|
      it "should encode #{string.inspect} properly with no padding/line break" do
        refute_match /\n|=/, b64_encode(string)
      end

      it "should correctly encode and decode #{string.inspect} to the same string" do
        str = b64_decode(b64_encode(string))
        str.force_encoding('UTF-8') if str.respond_to?(:force_encoding)
        assert_equal string, str
      end
    end

    describe "b64_decode" do
      it "converts (deprecated) '~' characters to '/' characters" do
        assert_equal b64_decode('asdf~asdf'), b64_decode('asdf/asdf')
      end
    end
  end

  [
      [3,4,5],
      {wo: 'there'},
      [{this: 'should', work: [3, 5.3, nil, {egg: false}]}, [], true]
  ].each do |object|
    it "should correctly json encode #{object.inspect} properly with no padding/line break" do
      encoded = json_b64_encode(object)
      assert_instance_of String, encoded
      refute_match /\n|=/, encoded
    end

    it "should correctly json encode and decode #{object.inspect} to the same object" do
      assert_equal object, json_b64_decode(json_b64_encode(object))
    end
  end

  describe "json_b64_decode" do
    it "should raise an error if the string passed in is empty" do
      assert_raises EncryptedObjects::BadString do
        json_b64_decode('')
      end
    end

    it "should raise an error if the string passed in is gobbledeegook" do
      assert_raises EncryptedObjects::BadString do
        json_b64_decode('ahasdkjfhasdkfjh')
      end
    end
  end
end
