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
    
}
