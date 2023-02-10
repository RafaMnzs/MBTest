//
//  Request.swift
//  Network
//
//  Created by Rafael Menezes on 07/02/23.
//

import Foundation

import Foundation

public enum Method: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public protocol Request {
    var host: String { get set }
    var path: String { get set }
    var method: Method { get set }
    var body: AnyHashable? { get set }
    var params: [String: AnyHashable]? { get set }
    var header: [String: AnyHashable]? { get set }
}
