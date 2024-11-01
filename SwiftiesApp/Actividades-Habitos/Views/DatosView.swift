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
    
    //@Environment(HabitModel.self) var habitModel
    
    @State var habits: [Habit]  = [Habit(frecuency: 1, name: "Baño de 15 minutos", date: Date()), Habit( frecuency: 1, name: "Beber una taza de café diaria", date: Date())]
    //Esto se tiene que cambiar
    @State var todayHabits: [Habit]  = [Habit(frecuency: 20, name: "Lavar mi coche", date: Date())]
    
    let dates : [Date] = getDaysSimple(for: Date())
    
    
    @State var currentMonth : Int = Calendar.current.component(.month, from: Date())
    @State var current : Int = Calendar.current.component(.day, from: Date())
    
    @State private var isShowingSearch: Bool = false
    @State private var isShowingAddHabitModal: Bool = false
    @State private var isShowingAddCompra: Bool = false
    
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
                        /*NavigationLink {
                         //DetallesActividadView(habitName: "")
                         ActividadesView()
                         } label: {
                         Text("Agregar hábito")
                         }.padding()
                         */
                        Button{
                            //habits.append(Habit(id: 3, frecuency: 1, name: "Habit3", date: Date()))
                            isShowingSearch=true
                            
                        } label: {
                            Text("Agregar hábito")
                        }.padding()
                        
                        NavigationLink{
                            CuestionarioView(current: $cuestionarioProgress)
                        }label: {
                            Text("Contestar cuestionario")
                        }.padding(.bottom)
                    }
                }else/*{
                      HoyView()
                      .padding(.horizontal)
                      }*/
                
                {
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
                        
                        //Esto se tiene que cambiar
                        VStack{
                            ForEach(todayHabits) { habit in
                                HStack{
                                    Text(habit.name).foregroundStyle(Color.white)
                                        .padding(.leading)
                                        .padding(.vertical, 5)
                                    Spacer()
                                    Text("\(habit.frecuency) minutos").foregroundStyle(Color.white)
                                        .padding(.trailing)
                                        .padding(.vertical, 5)
                                    
                                    
                                }
                                .background(Color.blue)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                
                            }
                        }
                        
                        Button{
                            isShowingAddCompra = true
                        }label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Agregar compra")
                            }
                            
                        }.padding()
                        
                        
                        Button{
                            isShowingAddHabitModal = true
                        } label: {
                            HStack{
                                Image(systemName: "plus")
                                Text("Agregar acción")
                            }
                        }.padding()
                        
                        Spacer()
                    }
                }
            }
            .background(EmptyView().fullScreenCover(isPresented: $isShowingSearch) { ActividadesView() }
                .background(EmptyView().fullScreenCover(isPresented: $isShowingAddHabitModal) { DetallesHoyView(habits: $todayHabits) }).background(EmptyView().fullScreenCover(isPresented: $isShowingAddCompra) { AgregarCompraView() }))
            
        }
    }
}

#Preview {
    DatosView()
}
