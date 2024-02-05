//
//  AnalyticsManager.swift
//  JoyStickFolio
//
//  Created by Karim Sakr on 05/02/2024.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    
    class func logEvent(event: AnaltyicsEvent, parameters: [String : Any]? = nil) {
        
        Analytics.logEvent(AnalyticsEventLogin, parameters: parameters)
    }
}
