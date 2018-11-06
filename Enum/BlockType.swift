//
//  BlockType.swift
//  Russian Block
//
//  Created by Chester Wong on 03/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import Foundation

enum BlockType: Int{
    case I_Block = 1
    case J_Block = 2
    case L_Block = 3
    case O_Block = 4
    case S_Block = 5
    case T_Block = 6
    case Z_Block = 7
    case Nothing = 0
}

func convertInttoBlockType(_ i: Int) -> BlockType{
    switch i {
    case 1:
        return .I_Block
    case 2:
        return .J_Block
    case 3:
        return .L_Block
    case 4:
        return .O_Block
    case 5:
        return .S_Block
    case 6:
        return .T_Block
    case 7:
        return .Z_Block
    default:
        return .Nothing
    }
}
