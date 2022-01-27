class DependencyInjectionManager {
    init(container: InjectionContainer = .default) {
        registerServiceDependencies(container: container)
        registerNetworkDependencies(container: container)
    }
    
    private func registerServiceDependencies(container: InjectionContainer) {
        container.register(CreditscoreService.self, mode: .useContainer) { resolver in
            return ConcreteCreditscoreService(
                networkManager: resolver.resolve()
            )
        }
    }
    
    private func registerNetworkDependencies(container: InjectionContainer) {
        container.register(NetworkManager.self, mode: .useContainer) { resolver in
            return ConcreteNetworkManager()
        }
    }
}
