//
//  PlatformPresenter.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/07/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

class PlatformPresenter {}

extension PlatformPresenter: PlatformInteractorOutput {
    
    func didGetPlatform(model: PlatformAPI) -> PlatformModels.ViewModels.Platform {
        return PlatformModels.ViewModels.Platform(id: model.id,
                                                     abbreviation: model.abbreviation,
                                                     category: model.category,
                                                     createdAt: model.createdAt,
                                                     name: model.name,
                                                     platformLogo: model.platformLogo,
                                                     slug: model.slug,
                                                     updatedAt: model.updatedAt,
                                                     url: model.url,
                                                     versions: model.versions,
                                                     checksum: model.checksum)
    }
}
