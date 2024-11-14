//
//  swiftiesApp.swift
//
//

import SwiftUI

@main
struct swiftiesApp: App {
    
    @StateObject private var user = User() // Create an instance of User
    @StateObject private var predictionStatus = PredictionStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(predictionStatus)
                .environmentObject(user) // Provide it to ContentView and all children
        }
    }
}
