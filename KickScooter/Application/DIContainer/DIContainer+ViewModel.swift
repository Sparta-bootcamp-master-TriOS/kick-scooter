extension DIContainer {
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(authorizeUserUseCase: makeAuthorizeUserUseCase())
    }
}
