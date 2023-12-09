//
//  LoginProcessData.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/12/2023.
//

import Foundation

struct RegisterationProcessData {
    
    static let allProcesses = [
        RegisterationProcess(title: "Well Hello There! \nGot a name?", placeholder: "Full Name...", buttonTitle: "Next", process: .enterFullName),
        RegisterationProcess(title: "Nice to meet you! \nHow can we contact you?", placeholder: "Email...", buttonTitle: "Next", process: .enterEmail),
        RegisterationProcess(title: "How about a unique nickname?\nLike everybody else...", placeholder: "Username...", buttonTitle: "Next", process: .enterUsername),
        RegisterationProcess(title: "How about some privacy? \n No peeking... \nI promise :)", placeholder: "Confirm Password...", buttonTitle: "Submit", process: .enterPassword),
        RegisterationProcess(title: "", placeholder: "", buttonTitle: "Submit", process: .confirm)
    ]
}
