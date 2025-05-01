import Alamofire

struct FetchAddressDataSource {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func execute(lon: String, lat: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://dapi.kakao.com/v2/local/geo/coord2address.json"
        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
        let parameters: Parameters = [
            "x": lon,
            "y": lat,
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddressResponse.self) { response in
                switch response.result {
                case let .success(data):
                    let addressName = data.documents.first?.address.addressName ?? "주소 없음"
                    completion(.success(addressName))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }
}
