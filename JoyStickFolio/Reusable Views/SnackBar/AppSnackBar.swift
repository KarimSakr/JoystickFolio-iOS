//
//  AppSnackBar.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 30/12/2023.
//

import Foundation
import SnackBar

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .tertiarySystemBackground
        style.textColor = .pinkApp
        return style
    }
}
