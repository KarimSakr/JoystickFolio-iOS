//
//  Router.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/02/2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    
    case twitchAuth(parameters: Parameters?)
    
    var baseUrl: String {
        switch self {
            
        case .twitchAuth:
            return Constants.Url.twitchAuth
        }
    }
    
    var path: String {
        switch self {
        case .twitchAuth:
            return ""
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        case .twitchAuth:
            return .post
        }
    }
    
    var type: Decodable.Type {
        
        switch self {
        case .twitchAuth(_):
            return IGDBAuth.self
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .twitchAuth(let parameters):
            urlRequest.url = url
            if let parameters = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
        }
        
        return urlRequest
    }

}
