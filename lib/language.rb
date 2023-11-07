require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_data(text)
      api_url = "https://language.googleapis.com/v1/documents:analyzeSentiment?key=#{ENV['GOOGLE_API_KEY']}"
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      response_body = JSON.parse(response.body)

      # ここを修正します。エラーがあれば例外を投げ、なければ全体のレスポンスボディを返します。
      if response_body['error']
        raise response_body['error']['message']
      else
        response_body
      end
    end
  end
end