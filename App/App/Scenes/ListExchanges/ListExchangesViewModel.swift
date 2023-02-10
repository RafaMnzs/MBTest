import Foundation

protocol ListExchangesViewModelOutput: AnyObject {
    func updateView(err: Error?)
}

class ListExchangesViewModel {
    
    public var exchanges:[Exchange] = [Exchange]()
    
    weak var delegate:ListExchangesViewModelOutput?
    private let service: ListExchangeServiceProtocol
    
    init(service: ListExchangeServiceProtocol = ListExchangeService()) {
        self.service = service
    }
    
    func fetch() {
        service.fetchExchanges { [weak self] result in
            switch result {
            case .success(let exchanges):
                self?.exchanges = exchanges.sorted(by: { $0.volume1DayUsd > $1.volume1DayUsd } )
                self?.delegate?.updateView(err: nil)
            case .failure(let err):
                self?.delegate?.updateView(err: err)
            }
        }
    }
}

