//
//  SingleBallmerChartView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/14/22.
//

import SwiftUI
import Charts

struct SingleBallmerChartView: View {
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    let data: BallmerProgrammer
    @State var showHydration: Bool = false
    @State var highlightPeak: Bool = false
    @State var lollipopValue: Double?
    
    var peakBAC: Double {
        let peakDataPoint = data.data.first { ballmerDataPoint in
            ballmerDataPoint.isPeak
        }
        return peakDataPoint!.bac
    }
    
    var body: some View {
        VStack {
            Chart(data.data) { ballmerDataPoint in
                switch selectedChartStyle {
                case .bar:
                    BarMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(ballmerDataPoint.isPeak && highlightPeak ?
                        .orange : .blue)
                case .line:
                    if showHydration {
                        BarMark(
                            x: .value("BAC", ballmerDataPoint.bac),
                            yStart: .value("Programming Skill", ballmerDataPoint.skill - 10),
                            yEnd: .value("Programming Skill", ballmerDataPoint.skill + 10))
                        .opacity(0.3)
                    }
                    LineMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .interpolationMethod(.catmullRom)
                case .area:
                    AreaMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                case .point:
                    PointMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                }
                if showPoint {
                    PointMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(ballmerDataPoint.isPeak && highlightPeak ?
                        .orange : .blue)
                }
                if highlightPeak && selectedChartStyle != .bar {
                    RuleMark(x: .value("Peak", peakBAC))
                        .foregroundStyle(.orange)
                }
                if let lollipopValue {
                    RuleMark(x: .value("Current Value", lollipopValue))
                        .foregroundStyle(.pink)
                        .lineStyle(.init(dash: [2], dashPhase: 5))
                        .annotation(position: .trailing) {
                            VStack(alignment: .leading) {
                                Text(data.name)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text((String(format: "BAC: %.2f", lollipopValue)))
                                    .font(.body)
                                Text("Skill: \(Int(ballmerDataPoint.skill))")
                                    .font(.body)
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
            
            HStack {
                Toggle(isOn: $highlightPeak.animation()) {
                    Text("Peak Performance")
                    Spacer()
                    Text(peakBAC.description)
                }
                .toggleStyle(.button)
                .background(.orange.opacity(0.2))
                .cornerRadius(5.0)
                if selectedChartStyle == .line {
                    Toggle(isOn: $showHydration.animation()) {
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
}

struct SingleBallmerChartView_Previews: PreviewProvider {
    static var previews: some View {
        SingleBallmerChartView(selectedChartStyle: .bar,
                               showPoint: true,
                               data: ballmer)
        .previewDisplayName("Single: Bar")
        .padding(.all)
        SingleBallmerChartView(selectedChartStyle: .line,
                               showPoint: true,
                               data: ballmer)
        .previewDisplayName("Single: Line")
        .padding(.all)
        SingleBallmerChartView(selectedChartStyle: .area,
                               showPoint: true,
                               data: ballmer)
        .previewDisplayName("Single: Area")
        .padding(.all)
        SingleBallmerChartView(selectedChartStyle: .point,
                               showPoint: true,
                               data: ballmer)
        .previewDisplayName("Single: Point")
        .padding(.all)
    }
}
