//
//  NetworkManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//

import Foundation
import Moya
enum NetworkManager {
    
    case twitchAuth,
         fetchGames
}


extension NetworkManager: TargetType {
    
    var baseURL: URL {
        switch self {
            
        case .twitchAuth:
            return URL(string: Constants.Url.BaseUrl.twitchAuthBaseUrl)!
            
        default:
            return URL(string: Constants.Url.BaseUrl.igdbBaseUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .twitchAuth:
            return Constants.Url.Endpoint.TwitchAuthEndpoint.tokenAuth
            
        case .fetchGames:
            return Constants.Url.Endpoint.igdbEndpoint.games
        }
    }
//    
//    var parameters: [String : String] {
//        switch self {
//        case .twitchAuth:
//            guard let bundle = Bundle.config,
//                  let dict = NSDictionary(contentsOfFile: bundle) as? [String: Any],
//                  let clientId = dict[Constants.BundleKey.clientId] as? String,
//                  let clientSecret = dict[Constants.BundleKey.clientSecret] as? String
//            else {
//                return [:]
//            }
//            
//            return [
//                "client_id" : clientId,
//                "client_secret" : clientSecret,
//                "grant_type" : "client_credentials"
//            ]
//        default: return [:]
//        }
//    }
//    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    
    var validationType : ValidationType {
        return .successCodes
    }
}

extension Constants.Url {
    
    struct BaseUrl {
        static let igdbBaseUrl = "https://api.igdb.com/v4"
        static let twitchAuthBaseUrl = "https://id.twitch.tv"
    }
    
    struct Endpoint {
        struct TwitchAuthEndpoint{
            static let tokenAuth = "oauth2/token"
        }
        
        struct igdbEndpoint {
            static let games = "games"
        }
    }
}



/*
 
    
    var endpoint: String {
       
    }
    
   
    
    var body: Data? {
        switch self {
            
        default: return nil
        }
    }
    
    var method: HTTPMethod {
        
        
    }
    
    var type: Decodable.Type {
        
        switch self {
        case .twitchAuth:
            return IGDBAuth.self
            
        case .fetchGames:
            return [Game].self
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint).appendingQueryParameters(parameters))
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = header
        return urlRequest
    }

}

extension URL {
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url!
    }
}


 */
