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

// Sample Data for Weekly, Monthly, and Yearly Views
var weeklyAnalytics: [RealGraphModel] = (0..<7).map { i in
    RealGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...10000))
}.reversed()

var monthlyAnalytics: [RealGraphModel] = (0..<30).map { i in
    RealGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...10000))
}.reversed()

var yearlyAnalytics: [RealGraphModel] = (0..<12).map { i in
    RealGraphModel(date: Date().monthsAgo(i), views: .random(in: 50000...100000))
}.reversed()

