@testable import ClearscoreApp
import Foundation

final class MockCreditscoreService: CreditscoreService {
    enum Invocation: Equatable {
        case fetchCreditscore
    }
    private(set) var invocations: [Invocation] = []
    
    var creditscoreResult: Result<CreditScoreModel, NetworkError> = .failure(.badResponse)
    func fetchCreditscore(completion: @escaping (Result<CreditScoreModel, NetworkError>) -> Void) {
        invocations.append(.fetchCreditscore)
        completion(creditscoreResult)
    }
}

