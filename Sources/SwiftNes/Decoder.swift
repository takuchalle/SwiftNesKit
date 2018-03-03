//
// Decoder.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Decoder {
    let InstructionTable: [Int:Instruction] = [
        // LDA: LoaD to A register
        0xA9: Instruction(opcode: .LDA, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA5: Instruction(opcode: .LDA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB5: Instruction(opcode: .LDA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xAD: Instruction(opcode: .LDA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBD: Instruction(opcode: .LDA, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0xB9: Instruction(opcode: .LDA, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0xA1: Instruction(opcode: .LDA, addressing: .IndirectX, bytes: 2, cycle: 6),
        0xB1: Instruction(opcode: .LDA, addressing: .IndirectY, bytes: 2, cycle: 5),

        // LDX: LoaD to X register
        0xA2: Instruction(opcode: .LDX, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA6: Instruction(opcode: .LDX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB6: Instruction(opcode: .LDX, addressing: .ZeroPageY, bytes: 2, cycle: 4),
        0xAE: Instruction(opcode: .LDX, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBE: Instruction(opcode: .LDX, addressing: .AbsoluteY, bytes: 3, cycle: 4),

        // LDY: LoaD to Y register
        0xA0: Instruction(opcode: .LDY, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA4: Instruction(opcode: .LDY, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB4: Instruction(opcode: .LDY, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xAC: Instruction(opcode: .LDY, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBC: Instruction(opcode: .LDY, addressing: .AbsoluteX, bytes: 3, cycle: 4),

        // STA: STore from A register
        0x85: Instruction(opcode: .STA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x95: Instruction(opcode: .STA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0x8D: Instruction(opcode: .STA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0x9D: Instruction(opcode: .STA, addressing: .AbsoluteX, bytes: 3, cycle: 5),
        0x99: Instruction(opcode: .STA, addressing: .AbsoluteY, bytes: 3, cycle: 5),
        0x81: Instruction(opcode: .STA, addressing: .IndirectX, bytes: 2, cycle: 6),
        0x91: Instruction(opcode: .STA, addressing: .IndirectY, bytes: 2, cycle: 6),

        // STX: STore from X register
        0x86: Instruction(opcode: .STX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x96: Instruction(opcode: .STX, addressing: .ZeroPageY, bytes: 2, cycle: 4),
        0xBE: Instruction(opcode: .STX, addressing: .Absolute,  bytes: 3, cycle: 4),

        // STY: STore from Y register
        0x84: Instruction(opcode: .STX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x94: Instruction(opcode: .STX, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xBC: Instruction(opcode: .STX, addressing: .Absolute,  bytes: 3, cycle: 4),

        // TAX: Transfer from A to X
        0xAA: Instruction(opcode: .TAX, addressing: .Implied,  bytes: 1, cycle: 2),

        // TAY: Transfer from A to Y
        0xA8: Instruction(opcode: .TAY, addressing: .Implied,  bytes: 1, cycle: 2),

        // TSX: Transfer from S to X
        0xBA: Instruction(opcode: .TSX, addressing: .Implied,  bytes: 1, cycle: 2),

        // TXA: Transfer from X to A
        0x8A: Instruction(opcode: .TXA, addressing: .Implied,  bytes: 1, cycle: 2),

        // TXS: Transfer from X to S
        0x9A: Instruction(opcode: .TXS, addressing: .Implied,  bytes: 1, cycle: 2),

        // TYA: Transfer from X to S
        0x98: Instruction(opcode: .TYA, addressing: .Implied,  bytes: 1, cycle: 2),
        ]

    static func decode() {
        
    }

    static func decodeAll() {
    }
}
