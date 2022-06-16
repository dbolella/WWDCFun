//
//  GaugeDemoView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/14/22.
//

import SwiftUI

struct GaugeDemoView: View {
    @State private var current = 14.0
    
    var body: some View {
        HStack {
            Button("-") {
                current = current - 2.0
            }
            .font(.title)
            BallmerGauge(current: $current)
            Button("+") {
                current = current + 2.0
            }
            .font(.title)
        }
        .navigationTitle("Gauge Demo")
    }
}

struct BallmerGauge: View {
    @Binding var current: Double
    @State private var minValue = 0.0
    @State private var maxValue = 26.0
    let gradient = Gradient(colors: [.yellow, .yellow, .orange, .green, .orange, .red, .red])
    
    func currentColor() -> Color {
        switch current {
        case 0.0..<10.0:
            return Color.yellow
        case 10.0..<14.0:
            return Color.orange
        case 14.0:
            return Color.green
        case 15.0...20.0:
            return Color.orange
        case 20...26:
            return Color.red
        default:
            return Color.blue
        }
    }

    var body: some View {
        Gauge(value: current, in: minValue...maxValue) {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        } currentValueLabel: {
            Text(".\(Int(current))")
                .foregroundColor(currentColor())
        } minimumValueLabel: {
            Text(".\(Int(minValue))")
                .foregroundColor(Color.green)
        } maximumValueLabel: {
            Text(".\(Int(maxValue))")
                .foregroundColor(Color.red)
        }
        .gaugeStyle(.accessoryCircular)
        .tint(gradient)
    }
}

struct GaugeDemoView_Previews: PreviewProvider {
    static var previews: some View {
        GaugeDemoView()
    }
}
