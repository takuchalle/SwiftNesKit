// 
// main for SwiftNesDisassemble
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation
import SwiftNesKit
import Commander

func usage() {
    print("Usage:")
    print("\tstep or s: step next instruction")
    print("\treg or r: dump current register")
    print("\tquit or q: quit application")
}

let main = command(
    Argument<String>("path")
) { path in
    guard let data = FileManager.default.contents(atPath: path) else {
        print("Failed to Open \(path)")
        exit(EXIT_FAILURE)
    }
    guard let nesfile = NesFile(data) else {
        print("Failed to Initialize nesfile")
        exit(EXIT_FAILURE)
    }

    var nes = SwiftNesKit()
    nes.load(with: nesfile)

    while(true) {
        nes.printCurrentInst()
        print("> ", terminator: "")

        guard let name = readLine() else {
            exit(EXIT_FAILURE)
        }
        switch name  {
        case "s", "step":
            nes.stepCPU()
        case "r", "reg":
            nes.printCurrentCpuReg()
        case "q", "quit":
            return
        default:
            usage()
        }
    }
}

main.run()
