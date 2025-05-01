extension DIContainer {
    func makeMapDataSource() -> MapDataSource {
        MapDataSource(apiKey: AppAPIKeys.kakaoAPIKey)
    }
}
