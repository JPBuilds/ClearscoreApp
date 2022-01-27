import Foundation

protocol NetworkManager {
    func request(urlRequest: URLRequest, response: @escaping (Result<Data, URLError>) -> Void)
}

class ConcreteNetworkManager: NetworkManager {
    func request(urlRequest: URLRequest, response: @escaping (Result<Data, URLError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let data = data { response(.success(data)) }
            else if let error = error as? URLError { response(.failure(error)) }
            else { response(.failure(.init(.unknown))) }
        }.resume()
    }
}
