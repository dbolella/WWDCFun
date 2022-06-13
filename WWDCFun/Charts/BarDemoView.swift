//
//  BarDemoView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/11/22.
//

import SwiftUI
import Charts

enum ViewStyle {
    case single, multi
}

enum Programmer {
    case ballmer, bolella
}

enum ChartStyle {
    case bar, line, area, point
}

struct BarDemoView: View {
    @State var selectedViewStyle: ViewStyle = .single
    @State var selectedChartStyle: ChartStyle = .bar
    @State var selectedProgrammer: Programmer = .ballmer
    @State var pointOn: Bool = true
    
    var isPointNotSelected: Bool {
        selectedChartStyle != .point
    }
    
    var showPoint: Bool {
        isPointNotSelected && pointOn
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50.0) {
                SelectedChartView
                ChartOptions
            }
            .padding(.all)
            .navigationTitle("Ballmer's Peak 🍺")
        }
    }
    
    var SelectedChartView: some View {
        Group {
            switch selectedViewStyle {
            case .single:
                SingleBallmerChartView(selectedProgrammer: selectedProgrammer,
                                       selectedChartStyle: selectedChartStyle,
                                       showPoint: showPoint)
            case .multi:
                MultiBallmerChartView(selectedProgrammer: selectedProgrammer,
                                       selectedChartStyle: selectedChartStyle,
                                       showPoint: showPoint)
            }
        }
    }
    
    var ChartOptions: some View {
        VStack {
            Picker("View Style", selection: $selectedViewStyle.animation(.easeInOut)) {
                Text("Single").tag(ViewStyle.single)
                Text("Multi").tag(ViewStyle.multi)
            }
            .pickerStyle(.segmented)
            if selectedViewStyle == .single {
                Picker("Programmer", selection: $selectedProgrammer.animation(.easeInOut)) {
                    Text("Ballmer").tag(Programmer.ballmer)
                    Text("Bolella").tag(Programmer.bolella)
                }
                .pickerStyle(.segmented)
            }
            Picker("Chart Style", selection: $selectedChartStyle.animation(.easeInOut)) {
                Text("Bar").tag(ChartStyle.bar)
                Text("Line").tag(ChartStyle.line)
                Text("Area").tag(ChartStyle.area)
                Text("Point").tag(ChartStyle.point)
            }
            .pickerStyle(.segmented)
            if(isPointNotSelected){
                Toggle(isOn: $pointOn.animation()) {
                    Text("PointMark")
                }
                .toggleStyle(.button)
                .background(.orange.opacity(0.2))
                .cornerRadius(5.0)
            }
        }
    }
}

struct SingleBallmerChartView: View {
    let selectedProgrammer: Programmer
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    @State var highlightPeak: Bool = false
    
    var data: BallmerProgrammer {
        switch selectedProgrammer {
        case .ballmer:
            return ballmer
        case .bolella:
            return bolella
        }
    }
    
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
                if highlightPeak {
                    RuleMark(x: .value("Peak", peakBAC))
                        .foregroundStyle(.orange)
                }
            }
            
            VStack {
                Toggle(isOn: $highlightPeak) {
                    Text("Peak Performance")
                    Spacer()
                    Text(peakBAC.description)
                }
                .toggleStyle(.button)
                .background(.orange.opacity(0.2))
                .cornerRadius(5.0)
            }
        }
    }
}

struct MultiBallmerChartView: View {
    let selectedProgrammer: Programmer
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    @State var highlightPeak: Bool = false
    
    var body: some View {
        Chart(ballmerProgrammers) { ballmerProgrammer in
            ForEach(ballmerProgrammer.data) { ballmerDataPoint in
                switch selectedChartStyle {
                case .bar:
                    BarMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                    .foregroundStyle(by: .value("Programmer", ballmerProgrammer.name))
                case .line:
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
        }
        .aspectRatio(contentMode: .fit)
        
        Toggle(isOn: $highlightPeak) {
            Text("Highlight Peak Performances")
        }
        .toggleStyle(.button)
        .background(.orange.opacity(0.2))
        .cornerRadius(5.0)
    }
}

struct BarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BarDemoView()
    }
}
