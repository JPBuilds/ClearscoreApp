import Foundation
protocol CreditscoreService {
    func fetchCreditscore(completion: @escaping  (Result<CreditScoreModel, NetworkError>) -> Void)
}

class ConcreteCreditscoreService: CreditscoreService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchCreditscore(completion: @escaping  (Result<CreditScoreModel, NetworkError>) -> Void) {
        // I'd usually use some kind of wrapped class like a `ApiNameRequestBuilder` for each api here but
        // it feels like massive overkill for the sake of a single url that doesn't change.
        let request = URLRequest(
            url: .init(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
        )
        networkManager.request(urlRequest: request, response: { result in
            switch result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(CreditScoreModel.self, from: data)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(.decodingError(error as? DecodingError)))
                }
            case .failure(let urlError):
                completion(.failure(.urlError(urlError.code)))
            }
        })
    }
}
