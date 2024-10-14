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
                     4: "Abril",
                     5: "Mayo",
                     6: "Junio",
                     7: "Julio",
                     8: "Agosto",
                    9: "Septiembre",
                     10: "Octubre",
                     11: "Noviembre",
                     12: "Diciembre"]
    let habits: [Habit]  = [Habit(id: 1, frecuency: 1, name: "Habit1"), Habit(id: 2, frecuency: 1, name: "Habit2")]

    var body: some View {
        NavigationStack{
            VStack {
                Picker("What is your favorite color?", selection: $selection) {
                    Text("Hábitos").tag(0)
                    Text("Diario").tag(1)
                }
                .pickerStyle(.segmented).padding()
                if (selection == 0){
                    Text("Hábitos").font(.largeTitle)
                    List{
                        ForEach(habits) { habit in
                            HabitListItem(habit: habit)
                        }
                    }.listStyle(PlainListStyle())
                }else{
                    Text((monthDict[month] ?? "Octubre") + " " + String(day)).font(.largeTitle)
                }
            }
        }
    }
}

#Preview {
    DatosView()
}
