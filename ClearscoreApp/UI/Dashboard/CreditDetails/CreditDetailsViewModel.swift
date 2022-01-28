import UIKit

struct CreditDetailsViewModel: Equatable {
    struct TableItem: Equatable {
        let fieldName: String
        let fieldValue: String
    }
    
    let items: [TableItem]
}
