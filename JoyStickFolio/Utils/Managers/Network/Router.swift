//
//  Router.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/02/2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    
    case twitchAuth(parameters: Parameters?),
         fetchgames
    
    var baseUrl: String {
        switch self {
            
        case .twitchAuth:
            return Constants.Url.twitchAuth
            
        default:
            return Constants.Url.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .twitchAuth:
            return ""
            
        case .fetchgames:
            return "games"
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        default:
            return .post
        }
    }
    
    var type: Decodable.Type {
        
        switch self {
        case .twitchAuth(_):
            return IGDBAuth.self
            
        case .fetchgames:
            return [Game].self
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
            
        case .fetchgames:
            urlRequest.httpBody = "fields name, cover; limit 3;".data(using: .utf8, allowLossyConversion: false)
            var accessToken: String!
            var clientId: String!
            do {
                accessToken = try Keychains.shared.getValue(key: Constants.Key.Persistence.accessToken)
                guard let bundle = Bundle.config else {
                    throw AppError.configFileMissing
                }
                
                let dict = NSDictionary(contentsOfFile: bundle) as! [String: Any]
                
                clientId = dict[Constants.BundleKey.clientId] as? String
            } catch {
                throw error
            }
            
            urlRequest.setValue(clientId, forHTTPHeaderField: "Client-ID")
            urlRequest.setValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        }
        
        return urlRequest
    }

}
