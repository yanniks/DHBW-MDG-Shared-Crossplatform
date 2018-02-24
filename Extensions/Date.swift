//
//  Date.swift
//  DHBW Stuttgart
//
//  Created by Yannik Ehlert on 28.04.17.
//  Copyright © 2017 Yannik Ehlert. All rights reserved.
//

import Foundation

public extension Date {
    func timeIsAfter(date: Date) -> Bool {
        var dateComponentCompare1 = Calendar.current.dateComponents([.hour, .minute, .weekday], from: Date())
        var dateComponentCompare2 = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        let dateComponent1 = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        let dateComponent2 = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        dateComponentCompare1.hour = dateComponent1.hour
        dateComponentCompare2.hour = dateComponent2.hour
        dateComponentCompare1.minute = dateComponent1.minute
        dateComponentCompare2.minute = dateComponent2.minute
        
        return Calendar.current.date(from: dateComponentCompare1)!.timeIntervalSince1970.isLess(than: Calendar.current.date(from: dateComponentCompare2)!.timeIntervalSince1970)
    }
    
    var localTimeFormat: String {
        let dfout = DateFormatter()
        dfout.dateStyle = .none
        dfout.timeStyle = .short
        return dfout.string(from: self)
    }
}

public extension String {
    func isoDateStringToDate() -> Date? {
        let df = ISO8601DateFormatter()
        return  df.date(from: self)
    }
    
    @available(*, deprecated)
    func isoDateStringToLocalTime() -> String {
        return isoDateStringToDate()!.localTimeFormat
    }
}
