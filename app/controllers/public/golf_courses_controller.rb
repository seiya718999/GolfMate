class Public::GolfCoursesController < ApplicationController
  
  def index
    @selected_sort = params[:sort]
    @sort_options = [
      ['クチコミの多い順', 'rating'], ['50音順', '50on'], ['都道府県別', 'prefecture'], ['高速道路順', 'highway'], ['予約件数順', 'reservation'],
      ['総合評価', 'evaluation'],['スタッフ接客', 'staff'],['設備が充実', 'facility'],['食事が美味しい', 'meal'],['コース/戦略性', 'course'],
      ['コストパフォーマンス', 'costperformance'],['距離が長い', 'distance'],['フェアウェイが広い', 'fairway'],['エンジョイ/カジュアル', 'friends'],
      ['接待/高級', 'entertainment'],['カップル', 'couple'],['アスリート', 'athlete'],['初心者', 'beginner'],['中級者', 'normal'],
      ['上級者', 'senior'],['女性', 'woman']]
    @area_codes = [
    ['全地域', 0],['北海道・東北のすべて', 101],['北海道', 1],['青森県', 2],['岩手県', 3],['宮城県', 4],['秋田県', 5],['山形県', 6],
    ['福島県', 7],['関東のすべて', 102],['茨城県', 8],['栃木県', 9],['群馬県', 10],['埼玉県', 11],['千葉県', 12],['東京都', 13],
    ['神奈川県', 14],['山梨県', 19],['長野県', 20],['静岡県', 22],['北陸のすべて', 103],['新潟県', 15],['富山県', 16],['石川県', 17],
    ['福井県', 18],['中部のすべて', 104],['岐阜県', 21],['愛知県', 23],['三重県', 24],['近畿のすべて', 105],['滋賀県', 25],
    ['京都府', 26],['大阪府', 27],['兵庫県', 28],['奈良県', 29],['和歌山県', 30],['中国のすべて', 106],['鳥取県', 31],['島根県', 32],
    ['岡山県', 33],['広島県', 34],['山口県', 35],['四国のすべて', 107],['徳島県', 36],['香川県', 37],['愛媛県', 38],['高知県', 39],
    ['九州・沖縄のすべて', 108],['福岡県', 40],['佐賀県', 41],['長崎県', 42],['熊本県', 43],['大分県', 44],['宮崎県', 45],['鹿児島県', 46],
    ['沖縄県', 47],['海外', 109]]
    
    api_key = ENV['GORA_API_KEY']
    keyword = params[:keyword]
    area_code = params[:area_code]
    sort_option = params[:sort]

    api = GoraApiService.new(api_key)

    response = api.search_golf_courses(keyword, area_code, sort_option)
    
    if response['error'] == 'not_found'
      flash[:alert] = '該当するゴルフ場はありません'
      redirect_to golf_courses_path and return
    end
    @results = response['Items'].map { |item| item['Item'] }
  end
  
  def show
    api_key = ENV['GORA_API_KEY']
    golf_course_id = params[:id]
    uri = URI.parse("https://app.rakuten.co.jp/services/api/Gora/GoraGolfCourseDetail/20170623?format=json&golfCourseId=#{golf_course_id}&applicationId=#{api_key}")
    

    response = Net::HTTP.get(uri)
    @golf_course_detail = JSON.parse(response)
    

    unless @golf_course_detail["Item"]
      redirect_to root_path, alert: "指定されたゴルフ場の詳細情報は取得できませんでした。"
    end
  end
  
end
