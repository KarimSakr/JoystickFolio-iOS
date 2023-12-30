//
//  LoginProcessData.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 04/12/2023.
//

import Foundation

let allProcesses = [
    RegistrationProcess(title: "Well Hello There! \nGot a name?", placeholder: "Full Name...", buttonTitle: "Next", process: .enterFullName),
    RegistrationProcess(title: "Nice to meet you! \nHow can we contact you?", placeholder: "Email...", buttonTitle: "Next", process: .enterEmail),
    RegistrationProcess(title: "How about a unique nickname?\nLike everybody else...", placeholder: "Username...", buttonTitle: "Next", process: .enterUsername),
    RegistrationProcess(title: "How about some privacy? \n No peeking... \nI promise :)", placeholder: "Confirm Password...", buttonTitle: "Submit", process: .enterPassword),
    RegistrationProcess(title: "Creating player...", placeholder: "", buttonTitle: "", process: .loading),
]

