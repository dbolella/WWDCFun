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
    var isPeak: Bool { skill == 100.0 }
    
    var id: Double { bac }
}

struct BallmerProgrammer: Identifiable {
    var name: String
    var data: [BallmerDataPoint]
    var peakBAC: Double {
        let peakDataPoint = data.first { ballmerDataPoint in
            ballmerDataPoint.isPeak
        }
        return peakDataPoint!.bac
    }
    
    var id: String { name }
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

var ballmer = BallmerProgrammer(name: "Ballmer", data: ballmerData)
var bolella = BallmerProgrammer(name: "Bolella", data: bolellaData)

var ballmerProgrammers: [BallmerProgrammer] = [
    ballmer,
    bolella
]
