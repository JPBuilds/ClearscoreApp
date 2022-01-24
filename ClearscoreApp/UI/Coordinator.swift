import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
//    func presentAlert(with viewModel: AlertViewModel)
}

extension Coordinator {
//    func presentAlert(with viewModel: AlertViewModel) {
//        let alert = UIAlertController(
//            title: viewModel.title,
//            message: viewModel.message,
//            preferredStyle: .alert
//        )
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        navigationController.present(alert, animated: true, completion: nil)
//    }
}
