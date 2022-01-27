struct CreditReportModel: Codable, Equatable {
    // Example object formatting that could be done if we knew all existing cases
    enum Status: String, Codable, Equatable {
        case match = "MATCH"
        case someOtherCase = "??"
    }
    
    let score: Int
    let scoreBand: Int
    let clientRef: String
    let status: Status
    let maxScoreValue: Int
    let minScoreValue: Int
    let monthsSinceLastDefaulted: Int
    let monthsSinceLastDelinquent: Int
    
    let hasEverDefaulted: Bool
    let hasEverBeenDelinquent: Bool
    
    let percentageCreditUsed: Int
    /// This is returned as an integer within the JSON. Although it's likely to return a 0 or 1 it's still not safe to assume even with a name like 'flag'
    let percentageCreditUsedDirectionFlag: Int
    let changedScore: Int

    let currentShortTermDebt: Int
    let currentShortTermNonPromotionalDebt: Int
    let currentShortTermCreditLimit: Int
    let currentShortTermCreditUtilisation: Int
    let changeInShortTermDebt: Int
    let currentLongTermDebt: Int
    let currentLongTermNonPromotionalDebt: Int
    let currentLongTermCreditLimit: Int?
    let currentLongTermCreditUtilisation: Int?
    let changeInLongTermDebt: Int
    let numPositiveScoreFactors: Int
    let numNegativeScoreFactors: Int
    let equifaxScoreBand: Int
    let equifaxScoreBandDescription: String
    let daysUntilNextReport: Int
}
