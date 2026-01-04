import Foundation

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case failure(String)
}

class BaseViewModel {
    // Common properties later (loading, error handling)
}
