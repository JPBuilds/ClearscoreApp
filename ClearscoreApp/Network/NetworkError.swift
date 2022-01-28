import Foundation

enum NetworkError: Error, Equatable {
    case urlError(URLError.Code)

    case badResponse
    case decodingError
    
    var isConnectionError: Bool {
        switch self {
        case .urlError(.notConnectedToInternet),
             .urlError(.networkConnectionLost),
             .urlError(.cannotConnectToHost),
             .urlError(.cannotFindHost),
             .urlError(.timedOut):
            return true
        default:
            return false
        }
    }
}

