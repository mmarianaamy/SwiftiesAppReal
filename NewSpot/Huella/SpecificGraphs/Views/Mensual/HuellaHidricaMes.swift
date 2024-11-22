//
//  HuellaHidricaMes.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 13/11/24.
//

import SwiftUI
import Charts

struct HuellaHidricaMes: View {
    @State private var graphType: GraphType = .bar
    @State private var barSelection: String?
    @State private var pieSelection: Double?
    @State private var loading : Bool = false
    var body: some View {
        VStack {
            HStack {
                Picker("", selection: $graphType) {
                    ForEach(GraphType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 300)
                .labelsHidden()
                Spacer()
            }
            
            ZStack {
                if let highestEmissions = hidricoMes.max(by: {
                    $1.emissions > $0.emissions
                }) {
                    if graphType == .bar {
                        ChartPopOverView(highestEmissions.emissions, highestEmissions.month, true)
                            .opacity(barSelection == nil ? 1 : 0)
                    } else {
                        if let barSelection, let selectedEmissions = hidricoMes.findEmissions(barSelection) {
                            ChartPopOverView(selectedEmissions, barSelection, true, true)
                        } else {
                            ChartPopOverView(highestEmissions.emissions, highestEmissions.month, true)
                        }
                    }
                }
            }
            .padding(.vertical)
            .task{
                loading = true
                for i in 0...5 {
                    var num = 0.0
                    let startofmonth = Calendar.current.date(byAdding: DateComponents(month: -i), to: Date().startOfMonth())
                    do{
                        var response: [datosFromDB]? = []
                        response = try await supabase
                            .rpc("datos_fecha4", params: datostoDB(usuario_id: 1, fechai: startofmonth!, fechaii: (startofmonth?.endOfMonth())!, huellabuscada: 1))
                            .execute()
                            .value
                        
                        for resp in response!{
                            let r = (resp.recurrencia == "Dia" ? 30 : (resp.recurrencia == "Semana" ? 4 : 30))
                            num += Double(resp.total_impacto) * Double(r)
                        }
                    }catch{
                        print("nope")
                    }
                    hidricoMes.append(.init(date: startofmonth!, emissions: num))
                }
                loading = false
            }
            
            if loading{
                ProgressView()
            }
            
            Chart {
                ForEach(hidricoMes.sorted(by: { graphType == .bar ? false : $0.emissions > $1.emissions })) { emission in
                    if graphType == .bar {
                        BarMark(
                            x: .value("Month", emission.month),
                            y: .value("Emissions", emission.emissions)
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", emission.month))
                    } else {
                        SectorMark(
                            angle: .value("Emissions", emission.emissions),
                            innerRadius: .ratio(graphType == .donut ? 0.61 : 0),
                            angularInset: graphType == .donut ? 6 : 1
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", emission.month))
                        .opacity(barSelection == nil ? 1 : (barSelection == emission.month ? 1 : 0.4))
                    }
                }
                
                if let barSelection {
                    RuleMark(x: .value("Month", barSelection))
                        .foregroundStyle(.gray.opacity(0.35))
                        .zIndex(-10)
                        .offset(yStart: -10)
                        .annotation(
                            position: .top,
                            spacing: 0,
                            overflowResolution: .init(x: .fit, y: .disabled)) {
                                if let emissions = hidricoMes.findEmissions(barSelection) {
                                    ChartPopOverView(emissions, barSelection)
                                }
                            }
                }
            }
            .chartXSelection(value: $barSelection)
            .chartAngleSelection(value: $pieSelection)
            .chartLegend(position: .bottom, alignment: graphType == .bar ? .leading : .center, spacing: 25)
            .frame(height: 300)
            .padding(.top, 10)
            .animation(.snappy, value: graphType)
            
        }
        .padding()
        .onChange(of: pieSelection, initial: false) { oldValue, newValue in
            if let newValue {
                findEmission(newValue)
            } else {
                barSelection = nil
            }
        }
    }
    
    @ViewBuilder
    private func ChartPopOverView(_ emissions: Double, _ month: String, _ isTitleView: Bool = false, _ isSelection: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(isTitleView && !isSelection ? "Impacto más alto" : "Impacto en mes")")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(spacing: 4) {
                Text(String(format: "%.0f", emissions))
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(month)
                    .font(.title3)
                    .textScale(.secondary)
            }
        }
        .padding(isTitleView ? [.horizontal] : [.all] )
        .background(Color("PopupColor").opacity(isTitleView ? 0 : 1), in: .rect(cornerRadius: 8))
        .frame(maxWidth: .infinity, alignment: isTitleView ? .leading : .center)
    }
    
    func findEmission(_ rangeValue: Double) {
        var initalValue: Double = 0.0
        let convertedArray = hidricoMes
            .sorted(by: { $0.emissions > $1.emissions })
            .compactMap { emission -> (String, Range<Double>) in
            let rangeEnd = initalValue + emission.emissions
            let tuple = (emission.month, initalValue..<rangeEnd)
            initalValue = rangeEnd
            return tuple
        }
        
        if let emission = convertedArray.first(where: {
            $0.1.contains(rangeValue)
        }) {
            barSelection = emission.0
        }
    }
}

#Preview {
    HuellaHidricaMes()
}
