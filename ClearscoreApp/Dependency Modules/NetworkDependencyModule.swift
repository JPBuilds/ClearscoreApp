class NetworkDependencyModule: DependencyInjectionModule {
    override func setUp() {
        container.register(NetworkManager.self, mode: .useContainer) { resolver in
            return ConcreteNetworkManager()
        }
    }
}
