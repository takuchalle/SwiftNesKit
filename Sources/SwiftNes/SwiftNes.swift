// 
// SwiftNes.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

public struct SwiftNes {
    private var cpu: CPU

    public init() {
        let memory = Memory()
        cpu = CPU(with: memory)
    }

    public mutating func load(with rom: NesFile) {
        /* Load Program to CPU Memory */
        cpu.load(with: rom.Program)

        /* TODO: Load Character to PPU Memory */

        /* After load all data, send reset signal */
        cpu.reset()
    }

    public mutating func stepCPU() {
        cpu.step()
    }

    public func printCurrentInst() {
        cpu.printInst()
    }

    public func printCurrentCpuReg() {
        cpu.printRegister()
    }
}
