import Foundation

protocol Dispatcher {
    func execute<T: Codable>(_ request: Request, to type: T.Type, completion: @escaping(Result<T, Error>) -> Void)
}

public class Service: Dispatcher {
    
   static let shared = Service()
    
    func execute<T: Codable>(_ request: Request, to type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var config = NSMutableURLRequest()
            config.url = URL(string: request.host + request.path)
            header(header: request.header, config: &config)

        switch request.method {
        case .GET:
            config.httpMethod = "GET"
            query(query: request.params, config: &config)
        case .POST:
            config.httpMethod = "POST"
            config.httpBody = try? JSONSerialization.data(withJSONObject: request.body as Any, options: .prettyPrinted)
        case .PUT:
            config.httpMethod = "PUT"
            config.httpBody = try? JSONSerialization.data(withJSONObject: request.body as Any, options: .prettyPrinted)
        case .DELETE:
            config.httpMethod = "DELETE"
            config.httpBody = try? JSONSerialization.data(withJSONObject: request.body as Any, options: .prettyPrinted)
        }
        
        let session = URLSession.shared
        session.dataTask(with: config as URLRequest, completionHandler: { data, response, error  in
            if error != nil {
                if let err = error {
                    completion(.failure(err))
                }
                return
            }
            DispatchQueue.main.async {
                do {
                    guard let data = data else { return }
                    data.printJSON()
                    let content = try JSONDecoder().decode(type, from: data)
                    completion(.success(content))
                } catch {
                    completion(.failure(error))
                }
            }
        }).resume()
    }
}

private extension Service {
    
    private func header(header: [String: AnyHashable]?, config: inout NSMutableURLRequest) {
        guard let params = header else { return }
        for (key, value) in params {
            config.addValue(value.description, forHTTPHeaderField: key)
        }
    }
    
    private func query(query: [String: AnyHashable]?, config: inout NSMutableURLRequest) {
        guard let queries = query else { return }
        var components = URLComponents()
        for (key, value) in queries {
            components.queryItems?.append(URLQueryItem(name: key.description, value: value.description))
        }
    }
}

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
