//
//  APIClient.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 06/05/2024.
//

import Foundation
import RxSwift
import Moya
import RxMoya

class APIClient {
    
    static let shared = APIClient()
    private let provider : MoyaProvider<NetworkManager>
    
    init(){
        provider = MoyaProvider<NetworkManager>()
    }
    
    func twitchAuth()-> Single<IGDBAuth> {
        return self.provider
            .rx
            .request(.twitchAuth)
            .map(IGDBAuth.self)
    }
    
    func getGames(offset: Int) -> Single<[GameAPI]> {
        return self.provider
            .rx
            .request(.getGames(offset))
            .map([GameAPI].self)
    }
    
    func getCovers(gameIds: [Int]) -> Single<[CoverAPI]> {
        return self.provider
            .rx
            .request(.getCovers(gameIds))
            .map([CoverAPI].self)
    }
    
}
