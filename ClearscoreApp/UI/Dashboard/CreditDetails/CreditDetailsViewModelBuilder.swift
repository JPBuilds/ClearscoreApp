import Foundation
struct CreditDetailsViewModelBuilder {
    static func build(with model: CreditScoreModel) -> CreditDetailsViewModel {
        guard
            let creditInfoData = try? JSONEncoder().encode(model.creditReportInfo),
            let dictionary = try? JSONSerialization.jsonObject(with: creditInfoData, options: .allowFragments) as? [String: Any]
        else {
            return CreditDetailsViewModel(items: [])
        }
        
        let tableItems = dictionary.compactMap({
            CreditDetailsViewModel.TableItem(fieldName: $0.key, fieldValue: "\($0.value)")
        })
        return CreditDetailsViewModel(items: tableItems)
    }
}
