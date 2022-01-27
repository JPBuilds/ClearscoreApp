import Foundation

enum NetworkError: Error {
    case urlError(URLError.Code)

    case badResponse
    case decodingError(DecodingError?)
    
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
