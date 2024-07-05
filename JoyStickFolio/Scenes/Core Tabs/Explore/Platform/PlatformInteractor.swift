//
//  PlatformInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

protocol PlatformInteractorOutput {
    func didGetPlatform(model: PlatformAPI) -> PlatformModels.ViewModels.Platform
    
}

protocol PlatformDataStore {
    var platform: PlatformAPI { get set }
}

class PlatformInteractor: PlatformDataStore {
    
    var presenter: PlatformInteractorOutput?
    var platform: PlatformAPI = PlatformAPI()
    
}

extension PlatformInteractor: PlatformViewControllerOutput {
    
    func getPlatform() -> Single<PlatformModels.ViewModels.Platform> {
        guard let presenter = presenter else {
            return Single<PlatformModels.ViewModels.Platform>.error(AppError.genericAppError)
        }
        return Single<PlatformModels.ViewModels.Platform>.just(presenter.didGetPlatform(model: platform))
    }
}
