class GoraApiService
  include HTTParty
  base_uri 'https://app.rakuten.co.jp/services/api/Gora/GoraGolfCourseSearch/20170623'

  def initialize(api_key)
    @api_key = api_key
  end

  def search_golf_courses(keyword, area_code, sort_option)
    encoded_keyword = keyword

    query_params = {
      format: 'json',
      applicationId: @api_key,
      keyword: encoded_keyword,
    }
    query_params[:areaCode] = area_code unless area_code.blank?
    query_params[:sort] = sort_option unless sort_option.blank?

    Rails.logger.info "Requesting URL: #{self.class.base_uri}?#{query_params.to_query}"

    response = self.class.get("", query: query_params)

    if response.success?
      return response.parsed_response
    else
      raise StandardError, "APIリクエストが失敗しました: #{response.code}"
    end
  end
end