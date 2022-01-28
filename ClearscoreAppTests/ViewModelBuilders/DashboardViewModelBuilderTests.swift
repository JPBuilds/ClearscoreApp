import XCTest
@testable import ClearscoreApp

final class DashboardViewModelBuilderTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_build_initial() throws {
        // Given state empty with no loading
        let state = DashboardInteractor.State(creditscore: nil, error: nil, isLoading: false)
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertNil(viewModel.creditScoreModel)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_isLoading() throws {
        // Given state is loading
        let state = DashboardInteractor.State(creditscore: nil, error: nil, isLoading: true)
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertNil(viewModel.creditScoreModel)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.showAsLoading, true)
    }
    
    func test_build_connectionError() throws {
        // Given state is loading
        let state = DashboardInteractor.State(creditscore: nil, error: .urlError(.networkConnectionLost), isLoading: false)
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertNil(viewModel.creditScoreModel)
        XCTAssertEqual(viewModel.errorModel?.titleText, "No network connection")
        XCTAssertEqual(viewModel.errorModel?.tryAgainButtonText, "Try again")
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_nonConnectionError() throws {
        // Given state is loading
        let state = DashboardInteractor.State(creditscore: nil, error: .decodingError, isLoading: false)
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertNil(viewModel.creditScoreModel)
        XCTAssertEqual(viewModel.errorModel?.titleText, "Oops! Failed to fetch credit data")
        XCTAssertEqual(viewModel.errorModel?.tryAgainButtonText, "Try again")
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_errorOverridesCredit() throws {
        // Given state contains both creditscore & error
        let state = DashboardInteractor.State(
            creditscore: .fake(),
            error: .decodingError,
            isLoading: false
        )
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields for error only
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertNil(viewModel.creditScoreModel)
        XCTAssertEqual(viewModel.errorModel?.titleText, "Oops! Failed to fetch credit data")
        XCTAssertEqual(viewModel.errorModel?.tryAgainButtonText, "Try again")
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_creditscore() throws {
        // Given state creditscore has basic values
        let state = DashboardInteractor.State(
            creditscore: .fake(score: 400, scoreBand: 1, maxScore: 500),
            error: nil,
            isLoading: false
        )
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertEqual(viewModel.creditScoreModel?.titleText, "Your credit score is:")
        XCTAssertEqual(viewModel.creditScoreModel?.scoreText, "400")
        XCTAssertEqual(viewModel.creditScoreModel?.outOfText, "out of 500")
        XCTAssertEqual(viewModel.creditScoreModel?.scoreTextColor, .red)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_creditscore_scoreBandHigh() throws {
        // Given state creditscore has a high scoreBand
        let state = DashboardInteractor.State(
            creditscore: .fake(score: 150, scoreBand: 5, maxScore: 800),
            error: nil,
            isLoading: false
        )
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertEqual(viewModel.creditScoreModel?.titleText, "Your credit score is:")
        XCTAssertEqual(viewModel.creditScoreModel?.scoreText, "150")
        XCTAssertEqual(viewModel.creditScoreModel?.outOfText, "out of 800")
        XCTAssertEqual(viewModel.creditScoreModel?.scoreTextColor, .green)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
    
    func test_build_creditscore_angle() throws {
        // Given state creditscore has a high scoreBand
        let state = DashboardInteractor.State(
            creditscore: .fake(score: 200, scoreBand: 3, minScore: 100, maxScore: 300),
            error: nil,
            isLoading: false
        )
        
        // When we build viewModel
        let viewModel = DashboardViewModelBuilder.build(with: state)
        
        // Then viewModel has expected fields
        XCTAssertEqual(viewModel.titleText, "Dashboard")
        XCTAssertEqual(viewModel.creditScoreModel?.titleText, "Your credit score is:")
        XCTAssertEqual(viewModel.creditScoreModel?.scoreText, "200")
        XCTAssertEqual(viewModel.creditScoreModel?.outOfText, "out of 300")
        XCTAssertEqual(viewModel.creditScoreModel?.percentageAngle, 0.5)
        XCTAssertEqual(viewModel.creditScoreModel?.scoreTextColor, .yellow)
        XCTAssertNil(viewModel.errorModel)
        XCTAssertEqual(viewModel.showAsLoading, false)
    }
}
