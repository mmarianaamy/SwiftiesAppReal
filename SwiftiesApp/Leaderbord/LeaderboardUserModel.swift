//
//  LeaderboardUser.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import Foundation

struct LeaderboardUser: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let emissions: Double
    let position: Int
    let prevPosition: Int?
}