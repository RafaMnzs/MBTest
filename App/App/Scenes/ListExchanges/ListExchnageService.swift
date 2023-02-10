import Foundation

struct ListExchangeRequest: Request {
    var host: String
    
    var path: String
    
    var method: Method
    
    var body: AnyHashable?
    
    var params: [String : AnyHashable]?
    
    var header: [String : AnyHashable]?
}

protocol ListExchangeServiceProtocol {
    func fetchExchanges(completion: @escaping(Result<[Exchange], Error>) -> Void)
}

class ListExchangeService: ListExchangeServiceProtocol {
    
    func fetchExchanges(completion: @escaping (Result<[Exchange], Error>) -> Void) {

        var request = ListExchangeRequest(host: "https://rest.coinapi.io", path: "/v1/exchanges", method: .GET)
        request.header = ["X-CoinAPI-Key":"C1E505B2-706F-4851-886A-AE2037F3EF3A"]
        
        Service.shared.execute(request, to: [Exchange].self) { result in
            switch result {
            case .success(let list):
                completion(.success(list))
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
    }
}


