//
//  MonitorBool.swift
//  Russian Block
//
//  Created by Chester Wong on 03/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import Foundation

class MonitorBool{
    var monitor: [[Bool]] = []
    
    init(){
        for _ in 0...21{
            var row: [Bool] = []
            for _ in 0...11{
                row.append(false)
            }
            row[0] = true
            row[11] = true
            monitor.append(row)
        }
        for i in 1...10{
            monitor[0][i] = true
            monitor[21][i] = true
        }
    }
    
    func isTrue(_ x: Int, _ y: Int) -> Bool {
        return monitor[x][y]
    }
}
