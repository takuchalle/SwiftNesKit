//
// Decoder.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Decoder {
    let InstructionTable: [Int:Instruction] = [
        // LDA: Load to A register
        0xA9: Instruction(opcode: .LDA, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA5: Instruction(opcode: .LDA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB5: Instruction(opcode: .LDA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xAD: Instruction(opcode: .LDA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBD: Instruction(opcode: .LDA, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0xB9: Instruction(opcode: .LDA, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0xA1: Instruction(opcode: .LDA, addressing: .IndirectX, bytes: 2, cycle: 6),
        0xB1: Instruction(opcode: .LDA, addressing: .IndirectY, bytes: 2, cycle: 5),

        // LDX: Load to X register
        0xA2: Instruction(opcode: .LDX, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA6: Instruction(opcode: .LDX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB6: Instruction(opcode: .LDX, addressing: .ZeroPageY, bytes: 2, cycle: 4),
        0xAE: Instruction(opcode: .LDX, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBE: Instruction(opcode: .LDX, addressing: .Absolute,  bytes: 3, cycle: 4),
    ]

    static func decode() {
        
    }

    static func decodeAll() {
    }
}
