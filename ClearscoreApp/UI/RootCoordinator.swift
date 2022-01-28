class RootCoordinator {
    private let sceneDelegate: SceneDelegate
    
    private var dashboardCoordinator: DashboardCoordinator!
    
    init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
        dashboardCoordinator = DashboardCoordinator(rootCoordinator: self)
    }
    
    func start() {
        // Handle potential authentication logic. User not signed in? start `authenticationCoordinator` instead
        // although here not the case..
        sceneDelegate.window?.rootViewController = dashboardCoordinator.start()
    }
}
