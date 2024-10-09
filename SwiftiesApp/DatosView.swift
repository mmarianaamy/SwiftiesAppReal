//
//  DatosView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI

struct DatosView: View {
    @State var selection = 0
    let day = Calendar.current.component(.day, from: Date())
    let month = Calendar.current.component(.month, from: Date())
    
    var monthDict = [1: "Enero",
                            2: "Febrero",
                            3: "Marzo",
                            9: "Octubre"]

    var body: some View {
        Picker("What is your favorite color?", selection: $selection) {
            Text("Hábitos").tag(0)
            Text("Diario").tag(1)
        }
        .pickerStyle(.segmented).padding()
        if (selection == 0){
            Text("Hábitos").font(.largeTitle)
        }else{
            Text(String(day) + " " + (monthDict[month] ?? "Octubre")).font(.largeTitle)
        }
    }
}

#Preview {
    DatosView()
}
