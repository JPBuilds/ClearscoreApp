@testable import ClearscoreApp
import Foundation

final class MockNetworkManager: NetworkManager {
    enum Invocation: Equatable {
        case request(request: URLRequest, queue: DispatchQueue)
        case requestObject(request: URLRequest, queue: DispatchQueue)
    }
    private(set) var invocations: [Invocation] = []
    
    var requestResponse: Result<Data, URLError> = .failure(.init(.unknown))
    func request(_ urlRequest: URLRequest, callbackQueue: DispatchQueue, response: @escaping (Result<Data, URLError>) -> Void) {
        invocations.append(.request(request: urlRequest, queue: callbackQueue))
        response(requestResponse)
    }
    
    var requestObjectResponse: Any? // Result<T: Decodable, NetworkError>
    func requestObject<T: Decodable>(_ urlRequest: URLRequest, callbackQueue: DispatchQueue, response: @escaping (Result<T, NetworkError>) -> Void) {
        invocations.append(.requestObject(request: urlRequest, queue: callbackQueue))
        if let requestResponse = requestObjectResponse as? Result<T, NetworkError> {
            response(requestResponse)
        }
    }
}

