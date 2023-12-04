//
//  LoginProcessData.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/12/2023.
//

import Foundation

struct RegisterationProcessData {
    
    static let allProcesses = [
        RegisterationProcess(title: "Well Hello There! \nGot a name?", placeholder: "Full Name...", buttonTitle: "Next"),
        RegisterationProcess(title: "Nice to meet you! \nHow can we contact you?", placeholder: "Email...", buttonTitle: "Next"),
        RegisterationProcess(title: "Can we verify that \nit is you and not some \nweirdo?", placeholder: "Phone Number... (Optional)", buttonTitle: "Next"),
        RegisterationProcess(title: "How about some privacy? \n No peeking... \nI promise :)", placeholder: "Password...", buttonTitle: "Submit"),
    ]
}
