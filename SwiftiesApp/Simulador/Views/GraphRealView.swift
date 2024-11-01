//
//  SiteView.swift
//  SwiftiesApp
//
//  Created by Jorge Salcedo on 30/10/24.
//

import SwiftUI
import Charts

struct GraphRealView: View {
    @Environment(\.colorScheme) var scheme
    @Binding var currentTab: String 
    @State var sampleAnalytics: [RealGraphModel] = weeklyAnalytics
    @State var currentActiveItem: RealGraphModel?
    @State var plotWidth: CGFloat = 0
    @State var isLineGraph: Bool = true  // Always true since we only want line graphs

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("CO2 Kg")
                        .fontWeight(.semibold)
                    
                    // Removed Picker from here
                }

                let totalValue = sampleAnalytics.reduce(0.0) { partialResult, item in
                    item.views + partialResult
                }

                Text(totalValue.stringFormat)
                    .font(.largeTitle.bold())
                
                AnimatedChart()
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill((scheme == .dark ? Color.black : Color.white).shadow(.drop(radius: 2)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .onChange(of: currentTab) { newValue in
            switch newValue {
            case "7 Days":
                sampleAnalytics = weeklyAnalytics
            case "Month":
                sampleAnalytics = monthlyAnalytics
            case "Year":
                sampleAnalytics = yearlyAnalytics
            default:
                sampleAnalytics = weeklyAnalytics
            }
            animateGraph(fromChange: true)
        }
    }

    @ViewBuilder
    func AnimatedChart() -> some View {
        let max = sampleAnalytics.max(by: { $0.views < $1.views })?.views ?? 0
        let unit: Calendar.Component = currentTab == "Year" ? .month : .day
        
        Chart {
            ForEach(sampleAnalytics) { item in
                if isLineGraph {
                    LineMark(
                        x: .value("Date", item.date, unit: unit),
                        y: .value("CO2 Kg", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("BackgroundColor").gradient)
                    .interpolationMethod(.catmullRom)
                    
                    AreaMark(
                        x: .value("Date", item.date, unit: unit),
                        y: .value("CO2 Kg", item.animate ? item.views : 0)
                    )
                    .foregroundStyle(Color("BackgroundColor").opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                }
            }
        }
        .chartYScale(domain: 0...(max + 5000))
        .frame(height: 200)
        .onAppear {
            animateGraph()
        }
    }

    func animateGraph(fromChange: Bool = false) {
        for (index, _) in sampleAnalytics.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * (fromChange ? 0.03 : 0.05)) {
                withAnimation(fromChange ? .easeInOut(duration: 0.6) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct GraphsView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a dummy binding for the preview
        GraphRealView(currentTab: .constant("7 Days"))
    }
}
