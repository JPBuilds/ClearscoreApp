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
        networkManager.requestObject(request, callbackQueue: .main, response: completion)
    }
}
