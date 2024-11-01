//
//  DonutChart.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 01/11/24.
//

import SwiftUI
import Charts

struct DonutChart: View {
    
    @State private var graphType: GraphType = .donut
    
    @State private var barSelection: String?
    @State private var pieSelection: Double?
    var body: some View {
        VStack {
            ZStack {
                if let totalEmissions = appDownloads.max(by: {
                    $1.emissions > $0.emissions
                }) {
                    
                    if let barSelection, let selectedDownloads = appDownloads.findDownloads(barSelection) {
                        ChartPopOverView(selectedDownloads, barSelection, true, true)
                    } else {
                        ChartPopOverView(totalEmissions.emissions, totalEmissions.type, true)
                    }
                    
                }
            }
            .padding(.vertical)
            Chart {
                ForEach(appDownloads.sorted(by: { graphType == .bar ? false : $0.emissions > $1.emissions })) { download in
                    
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
                                if let emissions = appDownloads.findDownloads(barSelection) {
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
    func ChartPopOverView(_ emissions: Double, _ type: String, _ isTitleView: Bool = false, _ isSelection: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(isTitleView && !isSelection ? "Total" : "\(type)") Emissions")
                .font(.title3)
                .foregroundStyle(.gray)
            
            HStack(spacing: 4) {
                Text(String(format: "%.0f", emissions))
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(type)
                    .font(.title3)
                    .textScale(.secondary)
            }
        }
        .padding(isTitleView ? [.horizontal] : [.all] )
        .background(Color("PopupColor").opacity(isTitleView ? 0 : 1), in: .rect(cornerRadius: 8))
        .frame(maxWidth: .infinity, alignment: isTitleView ? .leading : .center)
    }
    
    func findDownload(_ rangeValue: Double) {
        
        var initalValue: Double = 0.0
        let convertedArray = appDownloads
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
