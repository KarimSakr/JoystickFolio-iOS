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
                        switch error {
                        case .responseSerializationFailed(_):
                            observer.onError(APIClientError.invalidResponse)
                        case .sessionTaskFailed(let error):
                            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                                observer.onError(APIClientError.networkError)
                            } else {
                                observer.onError(error)
                            }
                        default:
                            observer.onError(error)
                        }
                    }
                }
            return Disposables.create()
        }
    }
}

enum APIClientError: LocalizedError {
    case networkError
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Failed to connect to the network"
        case .invalidResponse:
            return "Received invalid response from the server"
        }
    }
}
