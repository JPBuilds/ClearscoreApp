struct CreditScoreModel: Codable, Equatable {
    struct CoachingSummary: Codable, Equatable {
        let activeTodo: Bool
        let activeChat: Bool
        let numberOfTodoItems: Int
        let numberOfCompletedTodoItems: Int
        let selected: Bool
    }
    
    let accountIDVStatus: String
    let creditReportInfo: CreditReportModel
    let dashboardStatus, personaType: String
    let coachingSummary: CoachingSummary
    let augmentedCreditScore: Int?
}
