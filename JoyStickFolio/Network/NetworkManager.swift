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
         getGames(_ offset: Int),
         getCovers(_ gameIds: [Int]),
         getPlatforms(_ platformIds:[Int])
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
            
        case .getGames:
            return Constants.Url.Endpoint.igdbEndpoint.games
            
        case .getCovers:
            return Constants.Url.Endpoint.igdbEndpoint.covers
            
        case .getPlatforms:
            return Constants.Url.Endpoint.igdbEndpoint.platforms
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
            
            return .requestParameters(parameters: [
                "client_id"     : clientId,
                "client_secret" : clientSecret,
                "grant_type"    : "client_credentials",
            ], encoding: URLEncoding.queryString)
            
        case .getGames(let offset):
            return .requestData("fields *; limit 10; offset \(offset);".data(using: .utf8)!)
            
        case .getCovers(let gameIds):
            return .requestData("fields url; where id = (\(gameIds.map({String($0)}).joined(separator: ",")));".data(using: .utf8)!)
            
        case .getPlatforms(let platformsIds):
            return .requestData("fields *; where id = (\(platformsIds.map({String($0)}).joined(separator: ",")));".data(using: .utf8)!)
//        default:
//            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .twitchAuth:
            return [
                "Content-Type": "application/json"
            ]
            
        default:
            guard let bundle = Bundle.config,
                  let dict = NSDictionary(contentsOfFile: bundle) as? [String: Any],
                  let clientId = dict[Constants.BundleKey.clientId] as? String
            else {
                fatalError("Bundle Error")
            }
            return [
                "Client-ID": clientId,
                "Authorization": "Bearer \( try! Keychains.shared.getValue(key: Constants.Key.Persistence.accessToken))",
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
            static let covers = "covers"
            static let platforms = "platforms"
        }
    }
}
