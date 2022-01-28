import Foundation

protocol NetworkManager {
    func request(
        _ urlRequest: URLRequest,
        callbackQueue: DispatchQueue,
        response: @escaping (Result<Data, URLError>) -> Void
    )
    
    func requestObject<T: Decodable>(
        _ urlRequest: URLRequest,
        callbackQueue: DispatchQueue,
        response: @escaping (Result<T, NetworkError>) -> Void
    )
}

class ConcreteNetworkManager: NetworkManager {
    func request(
        _ urlRequest: URLRequest,
        callbackQueue: DispatchQueue = .main,
        response: @escaping (Result<Data, URLError>) -> Void
    ) {
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            callbackQueue.async {
                if let data = data { response(.success(data)) }
                else if let error = error as? URLError { response(.failure(error)) }
                else { response(.failure(.init(.unknown))) }
            }
        }.resume()
    }
    
    func requestObject<T: Decodable>(
        _ urlRequest: URLRequest,
        callbackQueue: DispatchQueue,
        response: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            callbackQueue.async {
                if let data = data {
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        response(.success(object))
                    } catch let error {
                        // You would replace print for some mind of error logging here probs
                        if let decodingError = error as? DecodingError {
                            print(decodingError)
                        }
                        
                        response(.failure(.decodingError))
                    }
                }
                else if let error = error as? URLError { response(.failure(.urlError(error.code))) }
                else { response(.failure(.urlError(.unknown))) }
            }
        }.resume()
    }
}
