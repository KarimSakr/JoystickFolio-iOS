//
//  Bundle.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 08/02/2024.
//

import Foundation

extension Bundle {
    static let config = Bundle.main.path(forResource: Constants.BundleKey.fileName, ofType: Constants.BundleKey.fileExtension)
}
