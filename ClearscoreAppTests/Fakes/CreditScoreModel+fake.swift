@testable import ClearscoreApp

extension CreditScoreModel {
    static func fake(score: Int = 500, scoreBand: Int = 4, minScore: Int = 0, maxScore: Int = 700) -> Self {
        let creditReport = CreditReportModel(
            score: score,
            scoreBand: scoreBand,
            clientRef: "clientRef",
            status: .match,
            maxScoreValue: maxScore,
            minScoreValue: minScore,
            monthsSinceLastDefaulted: 0,
            monthsSinceLastDelinquent: 0,
            hasEverDefaulted: false,
            hasEverBeenDelinquent: false,
            percentageCreditUsed: 0,
            percentageCreditUsedDirectionFlag: 0,
            changedScore: 0,
            currentShortTermDebt: 0,
            currentShortTermNonPromotionalDebt: 0,
            currentShortTermCreditLimit: 0,
            currentShortTermCreditUtilisation: 0,
            changeInShortTermDebt: 0,
            currentLongTermDebt: 0,
            currentLongTermNonPromotionalDebt: 0,
            currentLongTermCreditLimit: nil,
            currentLongTermCreditUtilisation: nil,
            changeInLongTermDebt: 0,
            numPositiveScoreFactors: 0,
            numNegativeScoreFactors: 0,
            equifaxScoreBand: 0,
            equifaxScoreBandDescription: "",
            daysUntilNextReport: 0
        )
        
        let coachingSummary = CreditScoreModel.CoachingSummary(
            activeTodo: false,
            activeChat: false,
            numberOfTodoItems: 0,
            numberOfCompletedTodoItems: 0,
            selected: false
        )
        
        return CreditScoreModel(
            accountIDVStatus: "",
            creditReportInfo: creditReport,
            dashboardStatus: "",
            personaType: "",
            coachingSummary: coachingSummary,
            augmentedCreditScore: nil
        )
    }
}
