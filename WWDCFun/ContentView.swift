//
//  ContentView.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 100.0) {
                Text("WWDC22 Fun 🎉")
                    .font(.largeTitle.bold())
                VStack(spacing: 50.0) {
                    NavigationLink {
                        ChartsDemoView()
                    } label: {
                        Label("Charts Demo", systemImage: "chart.bar.xaxis")
                            .font(.title)
                    }
                    NavigationLink {
                        GaugeDemoView()
                    } label: {
                        Label("Gauge Demo", systemImage: "gauge")
                            .font(.title)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
