//
//  CuestionarioView.swift
//  SwiftiesApp
//
//  Created by Alumno on 14/10/24.
//

import SwiftUI

struct CuestionarioView : View {
    @State private var progress = 0.5
    @State private var current = 0
    var body : some View {
        VStack{
            ProgressView(value: progress).padding()
            Text("¿De qué capacidad es tu lavadora?").font(.largeTitle)
            //Picker and Slider
            Button{
                current += 1
            } label: {
                Text("Next")
            }
        }
    }
}

#Preview {
    CuestionarioView()
}
