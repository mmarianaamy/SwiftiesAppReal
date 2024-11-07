//
//  SimulatedGraphModel.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 30/10/24.
//

import SwiftUI

struct SimulatedGraphModel: Identifiable {
    var id = UUID().uuidString
    var date: Date
    var views: Double
    var animate: Bool = false
}

// Sample Data for Weekly, Monthly, and Yearly Views
var weeklyAnalytics2: [SimulatedGraphModel] = (0..<7).map { i in
    SimulatedGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...7000))
}.reversed()

var monthlyAnalytics2: [SimulatedGraphModel] = (0..<30).map { i in
    SimulatedGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...7000))
}.reversed()

var yearlyAnalytics2: [SimulatedGraphModel] = (0..<12).map { i in
    SimulatedGraphModel(date: Date().monthsAgo(i), views: .random(in: 50000...70000))
}.reversed()

