//
//  EmissionViewModel.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 05/11/24.
//

import Foundation
import SwiftUI
import Combine
import Supabase
import GoogleGenerativeAI

class EmissionViewModel: ObservableObject {
    
    // MARK: BD
    let client = SupabaseClient(supabaseURL: URL(string: "https://hyufiwwpfhtovhspewlc.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh5dWZpd3dwZmh0b3Zoc3Bld2xjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyMDAzNDQsImV4cCI6MjA0NDc3NjM0NH0.Eol6hgROQO_G5CnGD6YBGTIMOMPKL6GX3xdMfpMlHmc")
    var habits: [HabitUser] = []
    
    struct valorhuella: Codable {
        var valorimpacto: Double
    }
    var result: [valorhuella] = []
    
    func fetchHabitsSemanal() async {
        var totalDiario = 0.0
        var totalSemanal = 0.0
        var totalMensual = 0.0
        var totalAnual = 0.0
        weeklyAnalytics = []
        monthlyAnalytics.removeAll()
        yearlyAnalytics.removeAll()
        
        weeklyAnalytics2.removeAll()
        monthlyAnalytics2.removeAll()
        yearlyAnalytics2.removeAll()
        var temp = 0.0
        
        var week: [Double] = [0,0,0,0,0,0,0]
        var month: [Double] = []
        
        for habit in habits {
            if habit.recurrencia == "Dia" {
                do {
                    result = try await client.from("habito_huella")
                        .select("valorimpacto")
                        .eq("idhuella", value: 2)
                        .eq("idhabito", value: habit.idhabito)
                        .execute()
                        .value
                    if !result.isEmpty {
                        temp = result.first!.valorimpacto
                    }
                    
                    totalDiario += (Double(temp) * Double(habit.frecuencia) * Double(habit.cantidad))
                    
                    
                    //print("\nFetched habits as appear on the database: \n \(habits)")
                } catch {
                    print("Error fetching dia valorimpacto: \(error)")
                }
            }
            if habit.recurrencia == "Semana"{
                do {
                    result = try await client.from("habito_huella")
                        .select("valorimpacto")
                        .eq("idhuella", value: 2)
                        .eq("idhabito", value: habit.idhabito)
                        .execute()
                        .value
                    if !result.isEmpty {
                        temp = result.first!.valorimpacto
                    }
                    
                    totalSemanal += (Double(temp) * Double(habit.frecuencia) * Double(habit.cantidad))
                    
                    
                    //print("\nFetched habits as appear on the database: \n \(habits)")
                } catch {
                    print("Error fetching dia valorimpacto: \(error)")
                }
            }
            if habit.recurrencia == "Mes" {
                do {
                    result = try await client.from("habito_huella")
                        .select("valorimpacto")
                        .eq("idhuella", value: 2)
                        .eq("idhabito", value: habit.idhabito)
                        .execute()
                        .value
                    if !result.isEmpty {
                        temp = result.first!.valorimpacto
                    }
                    
                    totalMensual += (Double(temp) * Double(habit.frecuencia) * Double(habit.cantidad))
                    
                    
                    //print("\nFetched habits as appear on the database: \n \(habits)")
                } catch {
                    print("Error fetching mes valorimpacto: \(error)")
                }
            }
        }
        totalSemanal/=2
        totalMensual/=5
        for i in 0..<7 {
            week[i] = totalDiario
        }
        week[.random(in: 0..<4)] += totalSemanal
        week[.random(in: 4...6)] += totalSemanal
        weeklyAnalytics = (0..<7).map { i in
            RealGraphModel(date: Date().daysAgo(i), views: Double(week[i]))
        }.reversed()
        
        weeklyAnalytics2 = (0..<7).map { i in
            SimulatedGraphModel(date: Date().daysAgo(i), views: Double(week[i]) * .random(in: 0.8...1))
        }.reversed()
        
        for _ in 0..<5 {
            month.append(contentsOf: week)
        }
        month[.random(in: 0..<6)] += totalMensual
        month[.random(in: 6..<12)] += totalMensual
        month[.random(in: 12..<18)] += totalMensual
        month[.random(in: 18..<21)] += totalMensual
        month[.random(in: 21..<28)] += totalMensual
        monthlyAnalytics = (0..<28).map { i in
            RealGraphModel(date: Date().daysAgo(i), views: Double(month[i]))
        }.reversed()
        
        monthlyAnalytics2 = (0..<28).map { i in
            SimulatedGraphModel(date: Date().daysAgo(i), views: Double(month[i]) * .random(in: 0.8...1))
        }.reversed()
        
        totalAnual = month.reduce(0, +)
        
        yearlyAnalytics = (0..<12).map { i in
            RealGraphModel(date: Date().monthsAgo(i), views: totalAnual)
        }.reversed()
        
        yearlyAnalytics2 = (0..<12).map { i in
            SimulatedGraphModel(date: Date().monthsAgo(i), views: totalAnual * .random(in: 0.6...1))
        }.reversed()
    }
    
    var weeklyAnalytics: [RealGraphModel] = []
    var monthlyAnalytics: [RealGraphModel] = []
    var yearlyAnalytics: [RealGraphModel] = []
    
    var weeklyAnalytics2: [SimulatedGraphModel] = []
    var monthlyAnalytics2: [SimulatedGraphModel] = []
    var yearlyAnalytics2: [SimulatedGraphModel] = []
    
    
    // Sample Data for Weekly, Monthly, and Yearly Views
    /*/ var weeklyAnalytics: [RealGraphModel] = (0..<7).map { i in
     RealGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...10000))
     }.reversed()*/
    
    /*var monthlyAnalytics: [RealGraphModel] = (0..<30).map { i in
     RealGraphModel(date: Date().daysAgo(i), views: .random(in: 1500...10000))
     }.reversed()*/
    
    /*var yearlyAnalytics: [RealGraphModel] = (0..<12).map { i in
     RealGraphModel(date: Date().monthsAgo(i), views: .random(in: 50000...100000))
     }.reversed()*/
    
    
    // Sample Data for Weekly, Monthly, and Yearly Views for simulated graph
    /*
     var weeklyAnalytics2: [SimulatedGraphModel] = (0..<7).map { i in
     SimulatedGraphModel(date: Date().daysAgo(i), views: .random(in: 1200...7000))
     }.reversed()
     
     var monthlyAnalytics2: [SimulatedGraphModel] = (0..<30).map { i in
     SimulatedGraphModel(date: Date().daysAgo(i), views: .random(in: 1200...7000))
     }.reversed()
     
     var yearlyAnalytics2: [SimulatedGraphModel] = (0..<12).map { i in
     SimulatedGraphModel(date: Date().monthsAgo(i), views: .random(in: 38000...70000))
     }.reversed()
     */
    
}
