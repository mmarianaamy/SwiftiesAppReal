//
//  DonutChart.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import Charts

struct datostoDB : Codable {
    var usuario_id : Int
    var fechai : Date
    var fechaii : Date
    var huellabuscada : Int
}

struct datosFromDB : Codable {
    var recurrencia : String
    var frecuencia : Int
    var cantidad : String
    var idhuella : Int
    var valorimpacto : Float
    var idusuario_habito : Int
    var total_impacto : Float
}

extension Date {
    func startOfMonth() -> Date {
        
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

var mockupDataTotalEmissions: [Emissions] = []

struct DonutChart: View {
    @EnvironmentObject var user : User
    
    @State private var graphType: GraphType = .donut
    @State private var barSelection: String?
    @State private var pieSelection: Double?
    @State var dataGot : [[datosFromDB]?] = []
    @State var isLoading : Bool = false
    
    func sumarValores(){
        isLoading = true
        var store = [0.0, 0.0, 0.0, 0.0]
        for l in 0...3{
            for i in dataGot[l]!{
                store[l] += (Double(i.total_impacto) * (i.recurrencia == "Dia" ? 30 : (i.recurrencia == "Semana" ? 4 : 30)))
            }
        }
        mockupDataTotalEmissions = [
            .init(type: "Hidrica", emissions: (store[0] / 100)),
            .init(type: "Carbono", emissions: store[1]),
            .init(type: "Energetica", emissions: store[2]),
            .init(type: "Residuos", emissions: store[3])
        ]
        isLoading = false
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let highestEmissions = mockupDataTotalEmissions.max(by: {
                    $1.emissions > $0.emissions
                }) {
                    
                    if let barSelection, let selectedDownloads = mockupDataTotalEmissions.findDownloads(barSelection) {
                        ChartPopOverView(selectedDownloads, barSelection, true, true)
                    } else {
                        ChartPopOverView(0, highestEmissions.type, true)
                    }
                    
                }
            }
            .padding(.vertical)
            if !isLoading{
                Chart {
                    ForEach(mockupDataTotalEmissions.sorted(by: { graphType == .bar ? false : $0.emissions > $1.emissions })) { download in
                        
                        SectorMark(
                            angle: .value("Downloads", download.emissions),
                            innerRadius: .ratio(graphType == .donut ? 0.61 : 0),
                            angularInset: graphType == .donut ? 6 : 1
                        )
                        .cornerRadius(8)
                        .foregroundStyle(by: .value("Month", download.type))
                        /// Fading Out All other Content, expect for the current selection
                        .opacity(barSelection == nil ? 1 : (barSelection == download.type ? 1 : 0.4))
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
                                    if let emissions = mockupDataTotalEmissions.findDownloads(barSelection) {
                                        ChartPopOverView(emissions, barSelection)
                                    }
                                }
                    }
                }
                .chartAngleSelection(value: $pieSelection)
                .chartLegend(position: .bottom, alignment: graphType == .bar ? .leading : .center, spacing: 25)
                .frame(height: 300)
                .padding(.top, 10)
                .animation(.snappy, value: graphType)
                .task{
                    do{
                        for i in 1...4{
                            var response: [datosFromDB]? = []
                            response = try await supabase
                                .rpc("datos_fecha4", params: datostoDB(usuario_id: 1, fechai: Date().startOfMonth(), fechaii: Date().endOfMonth(), huellabuscada: i))
                                .execute()
                                .value
                            dataGot.append(response)
                        }
                    }catch{
                        print("nope")
                    }
                    sumarValores()
                }
            }else{
                ProgressView()
            }
        }
        .padding()
        .onChange(of: pieSelection, initial: false) { oldValue, newValue in
            if let newValue {
                findDownload(newValue)
            } else {
                barSelection = nil
            }
        }
    }
    
    /// Chart Popover View
    @ViewBuilder
    private func ChartPopOverView(_ emissions: Double, _ type: String, _ isTitleView: Bool = false, _ isSelection: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(isTitleView && !isSelection ? "Tu impacto ambiental" : "\(type == "Hidrica" ? "Huella Hidrica" : type == "Energetica" ? "Huella Energetica" : type == "Carbono" ? "Huella de Carbono" : "t")") ")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(spacing: 4) {
                if emissions > 0 {
                    Text(String(format: "%.0f", emissions))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .textScale(.secondary)
                    Text(type == "Hidrica" ? "hL" : type == "Energetica" ? "kW" : type == "Carbono" ? "CO2e" : "t")
                        .font(.title3)
                        .textScale(.secondary)
                } else {
                    Text("Huella ecológica")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .font(.title3)
                        .textScale(.secondary)
                }
                
            }
        }
        .padding(isTitleView ? [.horizontal] : [.all] )
        .background(Color("PopupColor").opacity(isTitleView ? 0 : 1), in: .rect(cornerRadius: 8))
        .frame(maxWidth: .infinity, alignment: isTitleView ? .leading : .center)
    }
    
    func findDownload(_ rangeValue: Double) {
        
        var initalValue: Double = 0.0
        let convertedArray = mockupDataTotalEmissions
            .sorted(by: { $0.emissions > $1.emissions })
            .compactMap { download -> (String, Range<Double>) in
                let rangeEnd = initalValue + download.emissions
                let tuple = (download.type, initalValue..<rangeEnd)
                /// Updating Initial Value for next Iteration
                initalValue = rangeEnd
                return tuple
            }
        
        
        if let download = convertedArray.first(where: {
            $0.1.contains(rangeValue)
        }) {
            barSelection = download.0
        }
    }
}

#Preview {
    DonutChart()
}
