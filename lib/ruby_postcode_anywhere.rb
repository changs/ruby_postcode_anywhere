require 'net/http'
require 'rexml/document'

module PostcodeAnywhere

  class Response
    attr_accessor :errors, :response

    def success?
      errors.empty?
    end
  end

  class << self

    attr_accessor :key

  end

  def self.lookup(postcode)

    result = Response.new
    requestUrl = "http://services.postcodeanywhere.co.uk/PostcodeAnywhere/Interactive/RetrieveByParts/v1.00/xmle.ws?"
    requestUrl += "&key=#{PostcodeAnywhere.key}"
    requestUrl += "&postcode=#{URI.encode_www_form_component(postcode)}"

    xml_results = Net::HTTP.get_response(URI.parse(requestUrl))

    results = REXML::Document.new(xml_results.body)
    entries = Array.new

    result.errors = {}

    results.elements.each('Table/Row') do |row|
      entry = Hash.new

      row.elements.each('Error') do |element|
        row.elements.each('Description') do |element|
          result.errors[element.name.to_s] = element.text
          return result
        end
      end

      row.elements.each do |element|
        entry[element.name.to_s] = element.text
      end

      entries << entry
    end
    result.response = entries
    result
  end
end
