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

struct ChartsDemoView: View {
    @State var selectedViewStyle: ViewStyle = .single
    @State var selectedChartStyle: ChartStyle = .bar
    @State var selectedProgrammer: Programmer = .ballmer
    @State var pointOn: Bool = false
    
    var isPointNotSelected: Bool {
        selectedChartStyle != .point
    }
    
    var showPoint: Bool {
        isPointNotSelected && pointOn
    }
    
    var data: BallmerProgrammer {
        switch selectedProgrammer {
        case .ballmer:
            return ballmer
        case .bolella:
            return bolella
        }
    }
    
    var body: some View {
        VStack(spacing: 50.0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Ballmer Peak 🍺")
                SelectedChartView
            }
            ChartOptions
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.all)
        .navigationTitle("Charts Demo")
    }
    
    var SelectedChartView: some View {
        Group {
            switch selectedViewStyle {
            case .single:
                SingleBallmerChartView(selectedChartStyle: selectedChartStyle,
                                       showPoint: showPoint,
                                       data: data)
            case .multi:
                MultiBallmerChartView(selectedChartStyle: selectedChartStyle,
                                      showPoint: showPoint,
                                      data: ballmerProgrammers)
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

struct BarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsDemoView()
    }
}
