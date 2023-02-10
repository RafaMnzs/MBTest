import UIKit
import WebKit

class DetailExchangeViewController: UIViewController {

    private let viewModel: DetailExchangesViewModel
    
    init(viewModel: DetailExchangesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.exchange?.name
        setupViews()
    }
    
    private func setupViews() {
//        NSLayoutConstraint.activate([
//
//        ])
    }
}
