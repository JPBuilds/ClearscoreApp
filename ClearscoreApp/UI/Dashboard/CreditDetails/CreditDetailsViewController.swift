import UIKit

class CreditDetailsViewController: UIViewController {
    struct Layout {
        static let contentInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    private let creditscore: CreditScoreModel
    private let viewModel: CreditDetailsViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreditDetailCell.self, forCellReuseIdentifier: NSStringFromClass(CreditDetailCell.self))
        return tableView
    }()
    
    init(creditscore: CreditScoreModel) {
        self.creditscore = creditscore
        self.viewModel = CreditDetailsViewModelBuilder.build(with: creditscore)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        addComponents()
        layoutComponents()
        
        configure(with: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Credit Info"
        navigationController?.navigationBar.standardAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance?.configureWithOpaqueBackground()
    }
    
    private func addComponents() {
        view.addSubview(tableView)
    }

    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configure(with viewModel: CreditDetailsViewModel) {
        tableView.reloadData()
    }
}

extension CreditDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(CreditDetailCell.self)) as! CreditDetailCell
        cell.configure(with: viewModel.items[indexPath.row])
        return cell
    }
}
