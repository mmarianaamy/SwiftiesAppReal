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


