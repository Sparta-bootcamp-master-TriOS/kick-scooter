struct AddressResponse: Decodable {
    let documents: [Document]

    struct Document: Decodable {
        let address: Address
    }

    struct Address: Decodable {
        let addressName: String

        enum CodingKeys: String, CodingKey {
            case addressName = "address_name"
        }
    }
}
