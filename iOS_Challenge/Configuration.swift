//
//  Configuration.swift
//  iOS_Challenge
//
//  Created by Viraj Thenuwara on 3/9/21.
//

import UIKit

let GITHUB_TOKEN = "83d9b50736aeef7fef6092d43c036c90fea24092"
let GITHUB_USER_LOGIN = "krzysztofzablocki"

let bounds = UIScreen.main.bounds
let boundsWidth: CGFloat = bounds.size.width
let boundsHeight: CGFloat = bounds.size.height
let IS_TIME_TO_RELOAD_KET = "com.vtapps.iOS-Challenge.time.to.reload"

var isTimeToReload:Bool {
    get {
        if let cacheDate = UserDefaults.standard.value(forKey: IS_TIME_TO_RELOAD_KET) {
            let elapsed = Date().timeIntervalSince(cacheDate as! Date)
            let duration = Int(elapsed)
            if duration > 86400 { // 1 day 60 x 60 x 24
                UserDefaults.standard.setValue(Date(), forKey: IS_TIME_TO_RELOAD_KET)
                return true
            }
        } else {
            UserDefaults.standard.setValue(Date(), forKey: IS_TIME_TO_RELOAD_KET)
        }
        return false
    }
    set (newValue) {
        UserDefaults.standard.setValue(Date(), forKey: IS_TIME_TO_RELOAD_KET)
    }
}

func getDocumentsDirectory() -> String {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory.absoluteString
}
