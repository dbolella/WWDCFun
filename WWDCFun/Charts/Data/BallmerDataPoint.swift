//
//  BallmerDataPoint.swift
//  WWDCFun
//
//  Created by Daniel Bolella on 6/11/22.
//

import Foundation

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

struct BallmerProgrammer: Identifiable {
    var name: String
    var data: [BallmerDataPoint]
    
    var id: String { name }
}

var ballmerProgrammers: [BallmerProgrammer] = [
    BallmerProgrammer(name: "Ballmer", data: ballmerData),
    BallmerProgrammer(name: "Bolella", data: bolellaData)
]
