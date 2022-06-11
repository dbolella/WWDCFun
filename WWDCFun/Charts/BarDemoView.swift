//
//  BarDemoView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/11/22.
//

import SwiftUI
import Charts

struct BallmerDataPoint: Identifiable {
    var skill: Double
    var bac: Double
    
    var id: Double { bac }
}

var ballmerData = [
    BallmerDataPoint(skill: 50.0, bac: 0.0),
    BallmerDataPoint(skill: 45.0, bac: 0.02),
    BallmerDataPoint(skill: 40.0, bac: 0.04),
    BallmerDataPoint(skill: 30.0, bac: 0.06),
    BallmerDataPoint(skill: 20.0, bac: 0.08),
    BallmerDataPoint(skill: 10.0, bac: 0.1),
    BallmerDataPoint(skill: 5.0, bac: 0.12),
    BallmerDataPoint(skill: 100.0, bac: 0.14),
    BallmerDataPoint(skill: 5.0, bac: 0.16),
    BallmerDataPoint(skill: 4.0, bac: 0.18),
    BallmerDataPoint(skill: 3.0, bac: 0.2),
    BallmerDataPoint(skill: 2.0, bac: 0.22),
    BallmerDataPoint(skill: 1.0, bac: 0.24),
    BallmerDataPoint(skill: 1.0, bac: 0.26)
]

var bolellaData = [
    BallmerDataPoint(skill: 50.0, bac: 0.0),
    BallmerDataPoint(skill: 45.0, bac: 0.02),
    BallmerDataPoint(skill: 40.0, bac: 0.04),
    BallmerDataPoint(skill: 30.0, bac: 0.06),
    BallmerDataPoint(skill: 100.0, bac: 0.08),
    BallmerDataPoint(skill: 10.0, bac: 0.1),
    BallmerDataPoint(skill: 8.0, bac: 0.12),
    BallmerDataPoint(skill: 6.0, bac: 0.14),
    BallmerDataPoint(skill: 5.0, bac: 0.16),
    BallmerDataPoint(skill: 4.0, bac: 0.18),
    BallmerDataPoint(skill: 3.0, bac: 0.2),
    BallmerDataPoint(skill: 2.0, bac: 0.22),
    BallmerDataPoint(skill: 1.0, bac: 0.24),
    BallmerDataPoint(skill: 1.0, bac: 0.26)
]

struct ProgrammerData: Identifiable {
    let name: String
    let data: [BallmerDataPoint]
    
    var id: String { name }
}

var programmersData: [Programmer] = [
    ProgrammerData(name: "Ballmer", data: ballmerData),
    ProgrammerData(name: "Bolella", data: bolellaData)
]

enum ChartStyle {
    case bar, line, area, point
}

enum Programmer {
    case ballmer, bolella, both
}

struct BarDemoView: View {
    @State var selectedChartStyle: ChartStyle = .bar
    @State var pointOn: Bool = true
    @State var selectedProgrammer: Programmer = .ballmer
    
    var isPointNotSelected: Bool {
        selectedChartStyle != .point
    }
    
    var data: [BallmerDataPoint] {
        switch selectedProgrammer {
        case .ballmer:
            return ballmerData
        case .bolella:
            return bolellaData
        case .both:
            return []
        }
    }
    
    var body: some View {
        VStack(spacing: 50.0) {
            VStack {
                Picker("Programmer", selection: $selectedProgrammer.animation(.easeInOut)) {
                    Text("Ballmer").tag(Programmer.ballmer)
                    Text("Bolella").tag(Programmer.bolella)
                    Text("Both").tag(Programmer.both)
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
                if(selectedProgrammer != .both) {
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
                        if(pointOn && isPointNotSelected){
                            PointMark(
                                x: .value("BAC", ballmerDataPoint.bac),
                                y: .value("Programming Skill", ballmerDataPoint.skill))
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                } else {
                    Chart(programmersData) { ballmerData in
                        ForEach(ballmerData.data) { ballmerDataPoint in
                            
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
                            if(pointOn && isPointNotSelected){
                                PointMark(
                                    x: .value("BAC", ballmerDataPoint.bac),
                                    y: .value("Programming Skill", ballmerDataPoint.skill))
                            }
                        }
                    }
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
        .padding(.all)
    }
}

struct BarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BarDemoView()
    }
}
