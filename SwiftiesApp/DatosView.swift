//
//  DatosView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI

func getDaysSimple(for month: Date) -> [Date] {
    let cal = Calendar.current
    let monthRange = cal.range(of: .day, in: .month, for: month)!
    let comps = cal.dateComponents([.year, .month], from: month)
    var date = cal.date(from: comps)!

    var dates: [Date] = []
    for _ in monthRange {
        dates.append(date)
        date = cal.date(byAdding: .day, value: 1, to: date)!
    }
    
    return dates
}

struct DatosView: View {
    @State var selection = 0
    @State var cuestionarioProgress : Int = 0
    
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
    let habits: [Habit]  = [Habit(id: 1, frecuency: 1, name: "Habit1", date: Date()), Habit(id: 2, frecuency: 1, name: "Habit2", date: Date())]
    let dates : [Date] = getDaysSimple(for: Date())
    
    @State var currentMonth : Int = Calendar.current.component(.month, from: Date())
    @State var current : Int = Calendar.current.component(.day, from: Date())

    var body: some View {
        NavigationStack{
            VStack () {
                Picker("Habitos o diario", selection: $selection) {
                    Text("Hábitos").tag(0)
                    Text("Diario").tag(1)
                }
                .pickerStyle(.segmented).padding()
                if (selection == 0){
                    VStack{
                        Text("Hábitos").font(.largeTitle)
                        List{
                            ForEach(habits) { habit in
                                HabitListItem(habit: habit)
                            }
                        }.listStyle(PlainListStyle())
                        Button{
                            print()
                        } label: {
                            Text("Agregar hábito")
                        }.padding()
                        
                        NavigationLink{
                            CuestionarioView(current: $cuestionarioProgress)
                        }label: {
                            Text("Contestar cuestionario")
                        }
                    }
                }else{
                    VStack{
                        
                        HStack{
                            Text((monthDict[currentMonth] ?? "Octubre") + " " + String(current)).font(.largeTitle)
                            Spacer()
                            Button{
                                if (current > 1){
                                    current -= 1
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            Button{
                                if (current < 31){
                                    current += 1
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }.padding()
                        
                        HStack{
                            Text("Uso de baño").foregroundStyle(Color.white).padding()
                            Spacer()
                            Text("30 minutos").foregroundStyle(Color.white).padding()
                        }.frame(width: .infinity, height: 30).background(Color.blue).padding()
                        NavigationLink{
                            AddEventView()
                        }label: {
                            Button(){
                                print("hi")
                            }label: {
                                Text("Agregar")
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    DatosView()
}
