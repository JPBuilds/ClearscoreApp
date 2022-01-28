import UIKit

struct DashboardViewModelBuilder {
    static func build(with state: DashboardInteractor.State) -> DashboardViewModel {
        
        return DashboardViewModel(
            titleText: "Dashboard",
            creditScoreModel: state.error == nil ? Self.buildCreditscoreModel(with: state.creditscore) : nil,
            errorModel: Self.buildErrorViewModel(with: state.error),
            showAsLoading: state.isLoading
        )
    }
    
    private static func buildCreditscoreModel(with creditscore: CreditScoreModel?) -> DashboardViewModel.CreditScoreViewModel? {
        guard let creditscore = creditscore else {
            return nil
        }

        let score = creditscore.creditReportInfo.score
        let minScoreValue = creditscore.creditReportInfo.minScoreValue
        let maxScoreValue = creditscore.creditReportInfo.maxScoreValue
        
        let scoreBand = creditscore.creditReportInfo.scoreBand
        var scoreTextColor: UIColor
        if scoreBand < 2 {
            scoreTextColor = .red
        } else if scoreBand < 4 {
            scoreTextColor = .yellow
        } else {
            scoreTextColor = .green
        }
        
        return DashboardViewModel.CreditScoreViewModel(
            titleText: "Your credit score is:",
            scoreText: "\(score)",
            scoreTextColor: scoreTextColor,
            outOfText: "out of \(maxScoreValue)",
            percentageAngle: (CGFloat(score) - CGFloat(minScoreValue)) / CGFloat((maxScoreValue - minScoreValue))
        )
    }
    
    private static func buildErrorViewModel(with error: NetworkError?) -> DashboardViewModel.ErrorViewModel? {
        guard let error = error else {
            return nil
        }
        
        let title = error.isConnectionError ? "No network connection" : "Oops! Failed to fetch credit data"
        
        return DashboardViewModel.ErrorViewModel(
            titleText: title,
            tryAgainButtonText: "Try again"
        )
    }
}
