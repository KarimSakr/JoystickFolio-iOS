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

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
            
        case .twitchAuth:
            
            guard let bundle = Bundle.config,
                  let dict = NSDictionary(contentsOfFile: bundle) as? [String: Any],
                  let clientId = dict[Constants.BundleKey.clientId] as? String,
                  let clientSecret = dict[Constants.BundleKey.clientSecret] as? String
            else {
                fatalError("Bundle Error")
            }
            
            return .requestData(try! IGDBBody(client_id: clientId, client_secret: clientSecret, grant_type: "client_credentials").toJSON())
            
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

//MARK: - IGDB request -
extension NetworkManager {
    
    struct IGDBBody: JSONSerializable{
        var client_id: String
        var client_secret: String
        var grant_type: String
        
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
