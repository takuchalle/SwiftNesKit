// 
// main for SwiftNesDisassemble
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation
import Commander
import SwiftNes

let main = command(
  Argument<String>("path"),
  Flag("header", description: "Searches on cocoapods.org"),
  Flag("program", description: "Searches on cocoapods.org")
) { path, header, program in
    guard let data = FileManager.default.contents(atPath: path) else {
        print("Failed to Open \(path)")
        exit(EXIT_FAILURE)
    }

    guard let nesfile = NesFile(data) else {
        print("Failed to Initialize nesfile")
        exit(EXIT_FAILURE)
    }

    if header && program {
        nesfile.dumpAll()
    } else if header {
        nesfile.dumpHeader()
    } else if header {
        nesfile.dumpInstruction()
    } else {
        nesfile.dumpAll()
    }
}

main.run()


