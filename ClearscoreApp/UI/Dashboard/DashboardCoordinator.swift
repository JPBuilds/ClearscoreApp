import UIKit

class DashboardCoordinator {
    let rootCoordinator: RootCoordinator
    let navigationController: UINavigationController
    
    @Inject private var creditscoreService: CreditscoreService!
    
    init(rootCoordinator: RootCoordinator) {
        self.rootCoordinator = rootCoordinator
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundSecondary
        navigationController = UINavigationController()
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func start() -> UIViewController {
        let interactor = DashboardInteractor(creditscoreService: creditscoreService)
        let viewController = DashboardViewController(interactor: interactor)
        viewController.delegate = self
        
        navigationController.setViewControllers([viewController], animated: true)
        return navigationController
    }
    
    private func showCreditDetail(_ creditscore: CreditScoreModel) {
        let viewController = CreditDetailsViewController(creditscore: creditscore)
        navigationController.show(viewController, sender: nil)
    }
}

extension DashboardCoordinator: DashboardViewControllerDelegate {
    func viewController(_ viewController: DashboardViewController, wantsToShowDetail creditscore: CreditScoreModel) {
        showCreditDetail(creditscore)
    }
}
