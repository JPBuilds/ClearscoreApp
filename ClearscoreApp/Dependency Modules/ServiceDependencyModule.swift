class ServiceDependencyModule: DependencyInjectionModule {
    override func setUp() {
        container.register(CreditscoreService.self, mode: .useContainer) { resolver in
            return ConcreteCreditscoreService(
                networkManager: resolver.resolve()
            )
        }
    }
}
