//
//  SiteView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 30/10/24.
//

import SwiftUI

struct RealGraphModel: Identifiable {
    var id = UUID().uuidString
    var date: Date
    var views: Double
    var animate: Bool = false
}

extension Date {
    func daysAgo(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -days, to: self) ?? self
    }
    
    func monthsAgo(_ months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: -months, to: self) ?? self
    }
}

