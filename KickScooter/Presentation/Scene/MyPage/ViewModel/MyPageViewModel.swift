import Foundation

final class MyPageViewModel {
    private let myPageUseCase: MyPageUseCase

    private let mapper = UserUIMapper.shared

    init(myPageUseCase: MyPageUseCase) {
        self.myPageUseCase = myPageUseCase
    }
}
