import Alamofire

class MapDataSource {
    static let shared = MapDataSource()
    
    private init() {}
    
    private let apiKey = "Kakao REST API Key"
    
    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], Error>) -> Void) {
        let url = "https://dapi.kakao.com/v2/local/search/address.json"
        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
        let parameters: Parameters = ["query": query]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: MapAddressResponse.self) { response in
                switch response.result {
                case .success(let addressResponse):
                    completion(.success(addressResponse.documents))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
