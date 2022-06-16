//
//  MultiBallmerChartView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/14/22.
//

import SwiftUI
import Charts

struct MultiBallmerChartView: View {
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    let data: [BallmerProgrammer]
    @State var showHydration: Bool = false
    @State var highlightPeak: Bool = false
    @State var lollipopValue: Double?
    
    var ProgrammerSkillsText: some View {
        Group {
            ForEach(data) { dev in
                Text("\(dev.name): \(Int(dev.skillForBAC(lollipopValue ?? 0.0)))")
            }
        }
    }
    
    var body: some View {
        Chart(data) { ballmerProgrammer in
            ForEach(ballmerProgrammer.data) { ballmerDataPoint in
                switch selectedChartStyle {
                case .bar:
                    BarMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                case .line:
                    if showHydration {
                        BarMark(
                            x: .value("BAC", ballmerDataPoint.bac),
                            yStart: .value("Programming Skill", ballmerDataPoint.skill - 10),
                            yEnd: .value("Programming Skill", ballmerDataPoint.skill + 10))
                        .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                        .opacity(0.3)
                    }
                    LineMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                    .interpolationMethod(.catmullRom)
                case .area:
                    AreaMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                case .point:
                    PointMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                    .symbol(by: .value("Programmer", ballmerProgrammer.name))
                }
                if showPoint {
                    PointMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                    .symbol(by: .value("Programmer", ballmerProgrammer.name))
                }
            }
            
            if highlightPeak {
                RuleMark(x: .value("Peak", ballmerProgrammer.peakBAC))
                    .foregroundStyle(.orange)
            }
            if let lollipopValue {
                    RuleMark(x: .value("Current Value", lollipopValue))
                        .foregroundStyle(.pink)
                        .lineStyle(.init(dash: [2], dashPhase: 5))
                        .annotation(position: .trailing) {
                            VStack(alignment: .leading) {
                                Text((String(format: "Skills at BAC: %.2f", lollipopValue)))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                ProgrammerSkillsText
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 1)))
                            }
                        }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geoProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                if let bac: Double = proxy.value(atX: location.x) {
                                    let evenBAC = Double((Int(bac * 100.0) / 2) * 2) / 100.0
                                    lollipopValue = evenBAC
                                }
                            }
                            .onEnded { value in
                                lollipopValue = nil
                            }
                    )
            }
        }
        
        HStack {
            Toggle(isOn: $highlightPeak) {
                Text("Highlight Peak Performances")
            }
            .toggleStyle(.button)
            .background(.orange.opacity(0.2))
            .cornerRadius(5.0)
            if selectedChartStyle == .line {
                Toggle(isOn: $showHydration) {
                    Text("Show Hydration")
                    Spacer()
                    Text("+/- 10")
                }
                .toggleStyle(.button)
                .background(.orange.opacity(0.2))
                .cornerRadius(5.0)
            }
        }
    }
}

struct MultiBallmerChartView_Previews: PreviewProvider {
    static var previews: some View {
        MultiBallmerChartView(selectedChartStyle: .bar,
                              showPoint: true,
                              data: ballmerProgrammers)
        .previewDisplayName("Multi: Bar")
        .padding(.all)
        MultiBallmerChartView(selectedChartStyle: .line,
                              showPoint: true,
                              data: ballmerProgrammers)
        .previewDisplayName("Multi: Line")
        .padding(.all)
        MultiBallmerChartView(selectedChartStyle: .area,
                              showPoint: true,
                              data: ballmerProgrammers)
        .previewDisplayName("Multi: Area")
        .padding(.all)
        MultiBallmerChartView(selectedChartStyle: .point,
                              showPoint: true,
                              data: ballmerProgrammers)
        .previewDisplayName("Multi: Point")
        .padding(.all)
    }
}
