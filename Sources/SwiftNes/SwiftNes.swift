// 
// SwiftNes.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct SwiftNes {
    private let cpu: CPU

    init() {
        let memory = Memory()
        cpu = CPU(with: memory)
    }
}
