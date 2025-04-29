import Alamofire

class MapDataSource {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func searchAddress(query: String, completion: @escaping (Result<[MapResponse], Error>) -> Void) {
        let url = "https://dapi.kakao.com/v2/local/search/address.json"
        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
        let parameters: Parameters = ["query": query]

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: MapAddressResponse.self) { response in
                switch response.result {
                case let .success(addressResponse):
                    completion(.success(addressResponse.documents))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
