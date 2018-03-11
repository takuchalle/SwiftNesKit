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
    print("quit or q: quit application")
}

func inputCommant() {
    while(true) {
        print("type command")
        print("> ", terminator: "")

        guard let name = readLine() else {
            exit(EXIT_FAILURE)
        }
        switch name  {
        case "s", "step":
            print("step")
        case "q", "quit":
            return
        default:
            usage()
        }
    }
}

let main = command(
    Argument<String>("path")
) { path in
    guard let data = FileManager.default.contents(atPath: path) else {
        print("Failed to Open \(path)")
        exit(EXIT_FAILURE)
    }
    inputCommant()
}

main.run()
