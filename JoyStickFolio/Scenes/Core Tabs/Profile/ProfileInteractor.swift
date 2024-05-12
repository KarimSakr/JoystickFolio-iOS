//
//  ProfileInteractor.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 10/05/2024.
//  Copyright (c) 2024 Karim Sakr. All rights reserved.
//

import Foundation
import RxSwift

protocol ProfileInteractorOutput {
    
}

protocol ProfileDataStore {
    
}

class ProfileInteractor: ProfileDataStore{
    
    var presenter: ProfileInteractorOutput?
    
}

extension ProfileInteractor: ProfileViewControllerOutput{
    
}
