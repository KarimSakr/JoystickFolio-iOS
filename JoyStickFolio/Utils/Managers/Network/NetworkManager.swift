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
    
    func request<T: Codable>(rout: Router) -> Observable<T> {

        return Observable.create { observer in
            let request = AF
                .request(rout)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
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
