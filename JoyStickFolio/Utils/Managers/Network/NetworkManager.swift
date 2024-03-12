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
    
    func request<T: Codable>(router: Router) -> Observable<T> {
        
        return Observable.create { observer in
            AF.request(router)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        print(error.localizedDescription)
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
