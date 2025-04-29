protocol MyPageViewModelDelegate {
    associatedtype Action
    associatedtype State

    var action: ((Action) -> Void)? { get }
    var onStateChanged: ((State) -> Void)? { get }
}
