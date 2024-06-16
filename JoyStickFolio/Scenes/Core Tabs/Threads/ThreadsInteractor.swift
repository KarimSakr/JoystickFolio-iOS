//
//  ThreadsInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 12/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

protocol ThreadsInteractorOutput {
    
    
}

protocol ThreadsDataStore {
    
}

class ThreadsInteractor: ThreadsDataStore {
    
    var presenter: ThreadsInteractorOutput?
    
}

extension ThreadsInteractor: ThreadsViewControllerOutput {
    
}
