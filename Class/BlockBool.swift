//
//  BlockBool.swift
//  Russian Block
//
//  Created by Chester Wong on 03/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import Foundation

class BlockBool{
    var block : [[Bool]] = []
    var nothing : [[Bool]] = []
    var PositionInMonitor : [Int] = []
    var kind : BlockType = .Nothing
    
    init(){
        PositionInMonitor.append(5)
        PositionInMonitor.append(0)
        let temp_row : [Bool] = [false, false, false, false]
        for _ in 1...4{
            block.append(temp_row)
        }
        nothing = block
    }
    
    func clear_nothing(){
        for i in 0...3{
            for j in 0...3{
                nothing[i][j] = false
            }
        }
    }
    
    func assign(type : BlockType){
        block = nothing
        
        switch type {
        case .I_Block:
            block[1][0] = true
            block[1][1] = true
            block[1][2] = true
            block[1][3] = true
        case .J_Block:
            block[1][1] = true
            block[2][1] = true
            block[2][2] = true
            block[2][3] = true
        case .L_Block:
            block[2][0] = true
            block[2][1] = true
            block[2][2] = true
            block[1][2] = true
        case .O_Block:
            block[1][1] = true
            block[1][2] = true
            block[2][1] = true
            block[2][2] = true
        case .S_Block:
            block[1][1] = true
            block[1][2] = true
            block[2][0] = true
            block[2][1] = true
        case .T_Block:
            block[1][1] = true
            block[2][0] = true
            block[2][1] = true
            block[2][2] = true
        case .Z_Block:
            block[1][1] = true
            block[1][2] = true
            block[2][2] = true
            block[2][3] = true
        default:
            break
        }
        kind = type
    }
    
    func rotate(){
        for i in 0...3{
            for j in 0...3{
                nothing[i][j] = block[3-j][i]
                if(nothing[i][j]){
                    print(" 1 ")
                }
                else{
                    print(" 0 ")
                }
            }
            print()
        }
        block = nothing
        clear_nothing()
        
        
    }
    
    func setx(_ x: Int){
        PositionInMonitor[0] = x
    }
    func sety(_ y: Int){
        PositionInMonitor[1] = y
    }
    func getx() -> Int{
        return PositionInMonitor[0]
    }
    func gety() -> Int{
        return PositionInMonitor[1]
    }
    
    
}
