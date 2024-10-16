//
//  CuestionarioView.swift
//  SwiftiesApp
//
//  Created by Alumno on 14/10/24.
//

import SwiftUI

struct CuestionarioView : View {
    @Binding var current : Int
    var body : some View {
        VStack{
            ProgressView(value: Float(current) / 10).padding()
            Text("¿De qué capacidad es tu lavadora?").font(.largeTitle)
            MultipleResponseView()
            Button{
                current += 1
            } label: {
                Text("Next")
            }.padding()
        }
    }
}

#Preview {
    //CuestionarioView(current: 0)
}
