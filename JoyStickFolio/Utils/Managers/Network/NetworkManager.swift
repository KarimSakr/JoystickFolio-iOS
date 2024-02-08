//
//  NetworkManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 07/02/2024.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    func request<T: Codable>(of model: T.Type, endpoint: String, method: HTTPMethod, parameters: Parameters? = nil) -> Observable<T> {
        
        let headers: HTTPHeaders = [
            "Client-ID" : "CLIENT_ID",
            "Authorization" : "Bearer TOKEN"
        ]
        
        return Observable.create { observer in
            let request = AF
                .request(Constants.Url.baseUrl + endpoint,
                         method: method,
                         parameters: parameters,
                         encoding: JSONEncoding.default,
                         headers: headers)
                .responseDecodable(of: model.self) { response in
                
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
