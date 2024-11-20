//
//  DatosView.swift
//  SwiftiesApp
//
//  Created by Alumno on 09/10/24.
//

import SwiftUI
import Supabase

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
    @EnvironmentObject var user : User
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    
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
    
    @State var habits: [HabitUser]  = []
    @State var todayProducts: [UsuarioProduct]  = []
    @State var loading : Bool = false
    
    let dates : [Date] = getDaysSimple(for: Date())
    
    @State var currentMonth : Int = Calendar.current.component(.month, from: Date())
    @State var current : Int = Calendar.current.component(.day, from: Date())
    
    @State private var isShowingSearch: Bool = false
    @State private var isShowingAddHabitModal: Bool = false
    @State private var isShowingAddCompra: Bool = false
    
    var body: some View {
        NavigationStack {
            topView(title: "Datos")
            VStack {
                Picker("Hábitos o diario", selection: $selection) {
                    Text("Hábitos").tag(0)
                    Text("Diario").tag(1)
                }
                .pickerStyle(.segmented).padding()
                
                if (selection == 0) {
                    VStack {
                        Text("Hábitos").font(.largeTitle)
                        if loading {
                            ProgressView()
                            Spacer()
                        } else {
                            List {
                                ForEach(habits, id: \.self) { habit in
                                    HabitListItem(habit: habit)
                                }
                            }.listStyle(PlainListStyle())
                        }
                        
                        Button {
                            isShowingSearch = true
                        } label: {
                            Text("Agregar hábito")
                        }.padding()
                    }
                    .task {
                        loading = true
                        do {
                            habits = try await client.from("usuario_habito")
                                .select("recurrencia, frecuencia, cantidad, idhabito, fechainicio, fechafinal, habito(idhabito, nombre)")
                                .eq("idusuario", value: user.idusuario).execute().value
                        } catch {
                            print("Error fetching habits: \(error)")
                        }
                        loading = false
                    }
                    .background(EmptyView().fullScreenCover(isPresented: $isShowingSearch) { ActividadesView() })
                } else {
                    VStack {
                        HStack {
                            Text((monthDict[currentMonth] ?? "Octubre") + " " + String(current)).font(.largeTitle)
                            Spacer()
                            Button {
                                if (current > 1) {
                                    current -= 1
                                }
                                Task {
                                    loading = true
                                    do {
                                        todayProducts = try await client.from("usuario_producto")
                                            .select("idusuario, idproducto, cantidad, fecha, producto(idproducto, nombre, cantidad, unidad)")
                                            .eq("fecha", value: dates[current - 1])
                                            .eq("idusuario", value: user.idusuario).execute().value
                                    } catch {
                                        print("Error fetching products: \(error)")
                                    }
                                    loading = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                            Button {
                                if (current < 31) {
                                    current += 1
                                }
                                Task {
                                    loading = true
                                    do {
                                        todayProducts = try await client.from("usuario_producto")
                                            .select("idup, idusuario, idproducto, cantidad, fecha, producto(idproducto, nombre, cantidad, unidad)")
                                            .eq("fecha", value: dates[current - 1])
                                            .eq("idusuario", value: user.idusuario).execute().value
                                    } catch {
                                        print("Error fetching products: \(error)")
                                    }
                                    loading = false
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                            }
                        }.padding()
                        
                        VStack {
                            if loading {
                                ProgressView()
                            } else {
                                List{
                                    ForEach($todayProducts, id: \.self) { product in
                                        ActListItem(usuarioProducto: product.wrappedValue)
                                    }
                                }.listStyle(PlainListStyle())
                                
                            }
                        }
                        .task {
                            loading = true
                            do {
                                todayProducts = try await client.from("usuario_producto")
                                    .select("idusuario, idproducto, cantidad, fecha, producto(idproducto, nombre, cantidad, unidad)")
                                    .eq("fecha", value: dates[current - 1])
                                    .eq("idusuario", value: user.idusuario).execute().value
                            } catch {
                                print("Error: \(error)")
                            }
                            loading = false
                        }
                        
                        Button {
                            isShowingAddCompra = true
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Agregar compra")
                            }
                        }.padding()
                        
                        VStack {
                            NavigationLink(destination: CameraScanView(labelData: Classification())) {
                                Image(systemName: "camera")
                                Text("Escanear productos")
                            }
                        }.padding()
                        
                        VStack {
                            NavigationLink(destination: RecibosUtilidades()) {
                                Image(systemName: "text.document")
                                Text("Subir recibo")
                            }
                        }.padding()
                        
                        Spacer()
                    }
                }
            }
            .background(EmptyView().fullScreenCover(isPresented: $isShowingAddCompra) { AgregarCompraView() })
        }
    }
}

#Preview {
    DatosView().environmentObject(User(idusuario: 11, nombre: "Juan", apellido: "", email: "", contraseña: ""))
}
