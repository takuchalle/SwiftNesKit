// 
// main for SwiftNesDisassemble
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation
import SwiftNes
import Commander

func usage() {
    print("Usage:")
    print("step or s: step next instruction")
    print("reg or r: dump current register")
    print("quit or q: quit application")
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

    var nes = SwiftNes()
    nes.load(with: nesfile)

    while(true) {
        print("type command")
        print("> ", terminator: "")

        guard let name = readLine() else {
            exit(EXIT_FAILURE)
        }
        switch name  {
        case "s", "step":
            nes.stepCPU()
            print("step")
        case "r", "reg":
            print("reg")
        case "q", "quit":
            return
        default:
            usage()
        }
    }
}

main.run()
