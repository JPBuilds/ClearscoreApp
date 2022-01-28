import UIKit

struct DashboardViewModel: Equatable {
    struct CreditScoreViewModel: Equatable {
        let titleText: String
        let scoreText: String
        let scoreTextColor: UIColor
        let outOfText: String
        
        let percentageAngle: CGFloat
    }
    
    struct ErrorViewModel: Equatable {
        let titleText: String
        let tryAgainButtonText: String
    }
    
    let titleText: String
    let creditScoreModel: CreditScoreViewModel?
    let errorModel: ErrorViewModel?
    let showAsLoading: Bool
}
