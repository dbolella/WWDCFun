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
    var isPeak: Bool { skill == 90.0 }
    
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
    
    func skillForBAC(_ bac: Double) -> Double {
        let bdpForBAC = data.first { bdp in
            bdp.bac == bac
        }
        return bdpForBAC!.skill
    }
}

var ballmerData = [
    BallmerDataPoint(skill: 50.0, bac: 0.0),
    BallmerDataPoint(skill: 45.0, bac: 0.02),
    BallmerDataPoint(skill: 40.0, bac: 0.04),
    BallmerDataPoint(skill: 35.0, bac: 0.06),
    BallmerDataPoint(skill: 30.0, bac: 0.08),
    BallmerDataPoint(skill: 25.0, bac: 0.1),
    BallmerDataPoint(skill: 15.0, bac: 0.12),
    BallmerDataPoint(skill: 90.0, bac: 0.14),
    BallmerDataPoint(skill: 14.0, bac: 0.16),
    BallmerDataPoint(skill: 14.0, bac: 0.18),
    BallmerDataPoint(skill: 13.0, bac: 0.2),
    BallmerDataPoint(skill: 12.0, bac: 0.22),
    BallmerDataPoint(skill: 11.0, bac: 0.24),
    BallmerDataPoint(skill: 11.0, bac: 0.26)
]

var bolellaData = [
    BallmerDataPoint(skill: 50.0, bac: 0.0),
    BallmerDataPoint(skill: 45.0, bac: 0.02),
    BallmerDataPoint(skill: 40.0, bac: 0.04),
    BallmerDataPoint(skill: 35.0, bac: 0.06),
    BallmerDataPoint(skill: 30.0, bac: 0.08),
    BallmerDataPoint(skill: 25.0, bac: 0.1),
    BallmerDataPoint(skill: 15.0, bac: 0.12),
    BallmerDataPoint(skill: 13.0, bac: 0.14),
    BallmerDataPoint(skill: 90.0, bac: 0.16),
    BallmerDataPoint(skill: 13.0, bac: 0.18),
    BallmerDataPoint(skill: 13.0, bac: 0.2),
    BallmerDataPoint(skill: 12.0, bac: 0.22),
    BallmerDataPoint(skill: 11.0, bac: 0.24),
    BallmerDataPoint(skill: 11.0, bac: 0.26)
]

var ballmer = BallmerProgrammer(name: "Ballmer", data: ballmerData)
var bolella = BallmerProgrammer(name: "Bolella", data: bolellaData)

var ballmerProgrammers: [BallmerProgrammer] = [
    ballmer,
    bolella
]
