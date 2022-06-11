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
        VStack(spacing: 50.0) {
            VStack {
                Picker("View Style", selection: $selectedViewStyle.animation(.easeInOut)) {
                    Text("Single").tag(ViewStyle.single)
                    Text("Multi").tag(ViewStyle.multi)
                }
                .pickerStyle(.segmented)
                Picker("Programmer", selection: $selectedProgrammer.animation(.easeInOut)) {
                    Text("Ballmer").tag(Programmer.ballmer)
                    Text("Bolella").tag(Programmer.bolella)
                }
                .pickerStyle(.segmented)
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
                }
            }
            VStack {
                Text("🍺 Ballmer's Peak 🍺")
                    .font(.title)
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
        .padding(.all)
    }
}

struct SingleBallmerChartView: View {
    let selectedProgrammer: Programmer
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    
    var data: [BallmerDataPoint] {
        switch selectedProgrammer {
        case .ballmer:
            return ballmerData
        case .bolella:
            return bolellaData
        }
    }
    
    var body: some View {
        Chart(data) { ballmerDataPoint in
            switch selectedChartStyle {
            case .bar:
                BarMark(
                    x: .value("BAC", ballmerDataPoint.bac),
                    y: .value("Programming Skill", ballmerDataPoint.skill))
            case .line:
                LineMark(
                    x: .value("BAC", ballmerDataPoint.bac),
                    y: .value("Programming Skill", ballmerDataPoint.skill))
            case .area:
                AreaMark(
                    x: .value("BAC", ballmerDataPoint.bac),
                    y: .value("Programming Skill", ballmerDataPoint.skill))
            case .point:
                PointMark(
                    x: .value("BAC", ballmerDataPoint.bac),
                    y: .value("Programming Skill", ballmerDataPoint.skill))
            }
            if(showPoint){
                PointMark(
                    x: .value("BAC", ballmerDataPoint.bac),
                    y: .value("Programming Skill", ballmerDataPoint.skill))
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct MultiBallmerChartView: View {
    let selectedProgrammer: Programmer
    let selectedChartStyle: ChartStyle
    let showPoint: Bool
    
    var data: [BallmerDataPoint] {
        switch selectedProgrammer {
        case .ballmer:
            return ballmerData
        case .bolella:
            return bolellaData
        }
    }
    
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
                }
                if(showPoint){
                    PointMark(
                        x: .value("BAC", ballmerDataPoint.bac),
                        y: .value("Programming Skill", ballmerDataPoint.skill))
                }
            }
            
        }
        .aspectRatio(contentMode: .fit)
    }
}

struct BarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BarDemoView()
    }
}
