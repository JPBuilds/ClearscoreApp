import XCTest
@testable import ClearscoreApp

final class CreditscoreServiceTests: XCTestCase {
    private var creditscoreService: CreditscoreService!
    private var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkManager = MockNetworkManager()
        creditscoreService = ConcreteCreditscoreService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        mockNetworkManager = nil
        creditscoreService = nil
    }
    
    func test_fetchCreditscore_success() throws {
        // Given network returns CreditScoreModel
        let inputScore = 300
        mockNetworkManager.requestObjectResponse = Result<CreditScoreModel, NetworkError>.success(CreditScoreModel.fake(score: inputScore))
        
        // When attempt to fetch creditscore
        var foundResult: Result<CreditScoreModel, NetworkError>?
        creditscoreService.fetchCreditscore(completion: { result in foundResult = result})
        
        // Then result is success
        let result = try XCTUnwrap(foundResult)
        guard case .success(let value) = result else {
            XCTFail()
            return
        }
        
        // and contains correct score value
        XCTAssertEqual(value.creditReportInfo.score, inputScore)
    }
    
    func test_fetchCreditscore_failure() throws {
        // Given network returns error
        let inputError = NetworkError.decodingError
        mockNetworkManager.requestObjectResponse = Result<CreditScoreModel, NetworkError>.failure(inputError)
        
        // When attempt to fetch creditscore
        var foundResult: Result<CreditScoreModel, NetworkError>?
        creditscoreService.fetchCreditscore(completion: { result in foundResult = result })
        
        // Then result is failure
        let result = try XCTUnwrap(foundResult)
        guard case .failure(let error) = result else {
            XCTFail()
            return
        }
        
        // and contains correct error type
        XCTAssertEqual(error, inputError)
    }
}
