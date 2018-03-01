//
// Decoder.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Decoder {
    let InstructionTable: [Int:Instruction] = [
        0xA9: Instruction(opcode: .LDA, addressing: .Immediate, bytes: 1, cycle: 1)
    ]

    static func decode() {
        
    }

    static func decodeAll() {
    }
}
