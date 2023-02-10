import UIKit

private let cell_id = "ListExchangeTableViewCell"

class ListExchangesViewController: UIViewController {
    
    private let viewModel: ListExchangesViewModel
    
    lazy var tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        return _tableView
    }()
    
    init(viewModel: ListExchangesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
     
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Exchanges"
        view.backgroundColor = .orange
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80.0
        tableView.register(ListExchangeTableViewCell.self, forCellReuseIdentifier: cell_id)
        
        setupViews()
        fetchExchanges()
    }
    
    private func fetchExchanges() {
        viewModel.fetch()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ListExchangesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_id) as? ListExchangeTableViewCell {
            cell.config(exchange: viewModel.exchanges[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = DetailExchangesViewModel(exchange: viewModel.exchanges[indexPath.row])
        let detailViewController = DetailExchangeViewController(viewModel: model)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListExchangesViewController: ListExchangesViewModelOutput {
    
    func updateView(err: Error?) {
        self.tableView.reloadData()
        if let err = err {
            let alert = UIAlertController(title: "Message", message: err.localizedDescription, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
