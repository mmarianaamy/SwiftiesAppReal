//
//  SwiftiesAppApp.swift
//  SwiftiesApp
//
//  Created by Alumno on 08/10/24.
//

import SwiftUI

@main
struct SwiftiesAppApp: App {
    @StateObject private var user = User() // Create an instance of User
    @StateObject private var predictionStatus = PredictionStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user) // Provide it to ContentView and all children
                .environmentObject(predictionStatus)
        }
    }
}
