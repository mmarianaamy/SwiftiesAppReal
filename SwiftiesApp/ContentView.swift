//
//  ContentView.swift
//  SwiftiesApp
//
//  Created by Alumno on 08/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var logged = false
    var body: some View {
        if !logged{
            LoginPage(logged: $logged)
        }else{
            MenuView()
        }
    }
}

#Preview {
    ContentView()
}
