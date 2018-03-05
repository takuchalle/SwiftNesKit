//
// Instruction.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct Instruction {
    enum Opcode: String {
        case LDA = "LDA"
        case LDX = "LDX"
        case LDY = "LDY"
        case STA = "STA"
        case STX = "STX"
        case STY = "STY"
        case TAX = "TAX"
        case TAY = "TAY"
        case TSX = "TSX"
        case TXA = "TXA"
        case TXS = "TXS"
        case TYA = "TYA"
        case ADC = "ADC"
        case AND = "AND"
        case ASL = "ASL"
        case BIT = "BIT"
        case CMP = "CMP"
        case CPX = "CPX"
        case CPY = "CPY"
        case DEC = "DEC"
        case DEX = "DEX"
        case DEY = "DEY"
        case EOR = "EOR"
        case INC = "INC"
        case INX = "INX"
        case INY = "INY"
        case LSR = "LSR"
        case ORA = "ORA"
        case ROL = "ROL"
        case ROR = "ROR"
        case SBC = "SBC"
        case PHA = "RHA"
        case PHP = "PHP"
        case PLA = "PLA"
        case PLP = "PLP"
        case JMP = "JMP"
        case JSR = "JSR"
        case RTS = "RTS"
        case RTI = "RTI"
        case BCC = "BCC"
        case BCS = "BCS"
        case BEQ = "BEQ"
        case BMI = "BMI"
        case BNE = "BNE"
        case BPL = "BPL"
        case BVC = "BVC"
        case BVS = "BVS"
        case CLC = "CLC"
        case CLD = "CLD"
        case CLI = "CLI"
        case CLV = "CLV"
        case SEC = "SEC"
        case SED = "SED"
        case SEI = "SEI"
        case BRK = "BRK"
        case NOP = "NOP"
        case SLO = "SLO"
    }
    
    enum Addressing {
        case ZeroPage
        case Relative
        case Implied
        case Absolute
        case Accumulator
        case Immediate
        case ZeroPageX
        case ZeroPageY
        case AbsoluteX
        case AbsoluteY
        case IndirectX
        case IndirectY
        case Indirect
        case None
    }

    let opcode: Opcode 
    let addressing: Addressing
    let bytes: UInt8
    let cycle: UInt8
}
