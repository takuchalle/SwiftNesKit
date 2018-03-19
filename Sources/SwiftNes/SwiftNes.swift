// 
// SwiftNes.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

public struct SwiftNes {
    private var cpu: CPU
    private var ppu: PPU

    public init() {
        let memory = Memory()
        cpu = CPU(with: memory)

        ppu = PPU()
    }

    public mutating func load(with rom: NesFile) {
        /* Load Program to CPU Memory */
        cpu.load(with: rom.Program)

        /* TODO: Load Character to PPU Memory */
        connectCpuPpu(with: self.ppu)

        /* After load all data, send reset signal */
        cpu.reset()
    }

    mutating func connectCpuPpu(with ppu: PPU) {
        cpu.setIOreg(at: 0x2000, callback: { (value:UInt8?) -> (UInt8) in
                                     ppu.setPPUCTRL(with: value!)
                                     return UInt8(0)
                                 })
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
