//
//  NotificationHelper.swift
//  ToDo
//
//  Created by Jaylen Scott on 11/5/21.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationHelper {
    static func getTriggerDate() -> DateComponents? {
        let triggerDate =  Date().addingTimeInterval(10)
        return Calendar.current.dateComponents([.timeZone, .year, .month, .day, .hour, .minute, .second], from: triggerDate)
    }
}
