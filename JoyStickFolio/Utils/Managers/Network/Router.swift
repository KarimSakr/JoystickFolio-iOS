//
//  Router.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/02/2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    
    case twitchAuth,
         fetchGames
    
    var baseUrl: String {
        switch self {
            
        case .twitchAuth:
            return Constants.Url.BaseUrl.twitchAuthBaseUrl
            
        default:
            return Constants.Url.BaseUrl.igdbBaseUrl
        }
    }
    
    var endpoint: String {
        switch self {
        case .twitchAuth:
            return Constants.Url.Endpoint.TwitchAuthEndpoint.tokenAuth
            
        case .fetchGames:
            return Constants.Url.Endpoint.igdbEndpoint.games
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .twitchAuth:
            guard let bundle = Bundle.config,
                  let dict = NSDictionary(contentsOfFile: bundle) as? [String: Any],
                  let clientId = dict[Constants.BundleKey.clientId] as? String,
                  let clientSecret = dict[Constants.BundleKey.clientSecret] as? String
            else {
                return [:]
            }
            
            return [
                "client_id" : clientId,
                "client_secret" : clientSecret,
                "grant_type" : "client_credentials"
            ]
        default: return [:]
        }
    }
    
    var body: Data? {
        switch self {
            
        default: return nil
        }
    }
    
    var method: HTTPMethod {
        
        switch self {
        default:
            return .post
        }
    }
    
    var header: [String : String] {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
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
