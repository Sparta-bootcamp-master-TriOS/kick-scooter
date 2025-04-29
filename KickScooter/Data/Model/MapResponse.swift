struct MapAddressResponse: Codable {
    let documents: [MapResponse]
}

struct MapResponse: Codable {
    let addressName: String
    let lon: String
    let lat: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case lon = "x"
        case lat = "y"
    }
}
