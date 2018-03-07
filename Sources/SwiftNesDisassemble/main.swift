// 
// main for SwiftNesDisassemble
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation
import SwiftNes

func usage() {
    let path = URL(fileURLWithPath: CommandLine.arguments.first!)
    print("Usage: \(path.lastPathComponent) [input nes file]")
}

let arguments = CommandLine.arguments
let arg1 = arguments.dropFirst().first

guard let path = arg1 else {
    usage()
    exit(EXIT_FAILURE)
}

guard let data = FileManager.default.contents(atPath: path) else {
    print("Failed to Open \(path)")
    exit(EXIT_FAILURE)
}

guard let nesfile = NesFile(data) else {
    print("Failed to Initialize nesfile")
    exit(EXIT_FAILURE)
}

nesfile.dumpAll()
