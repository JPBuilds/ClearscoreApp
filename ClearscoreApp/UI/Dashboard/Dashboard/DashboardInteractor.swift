protocol DashboardInteractorDelegate: AnyObject {
    func interactor(_ interactor: DashboardInteractor, didUpdateViewModel viewModel: DashboardViewModel)
}

class DashboardInteractor {
    struct State: Equatable {
        private(set) var creditscore: CreditScoreModel? = nil
        private(set) var error: NetworkError? = nil
        private(set) var isLoading: Bool = false

        mutating func startLoading() {
            isLoading = true
            error = nil
        }

        mutating func loaded(creditscore: CreditScoreModel) {
            self.isLoading = false
            self.creditscore = creditscore
        }
        
        mutating func failed(with error: NetworkError) {
            self.isLoading = false
            self.error = error
        }
    }
    
    weak var delegate: DashboardInteractorDelegate?
    private let creditscoreService: CreditscoreService
    
    private(set) var state: State = State() {
        didSet {
            guard state != oldValue else { return }
            viewModel = DashboardViewModelBuilder.build(with: state)
        }
    }

    private(set) var viewModel: DashboardViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            delegate?.interactor(self, didUpdateViewModel: viewModel)
        }
    }

    init(creditscoreService: CreditscoreService) {
        self.creditscoreService = creditscoreService
        self.viewModel = DashboardViewModelBuilder.build(with: state)
    }
    
    func load() {
        state.startLoading()
        creditscoreService.fetchCreditscore(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let creditScore): self.state.loaded(creditscore: creditScore)
            case .failure(let error): self.state.failed(with: error)
            }
        })
    }
}
