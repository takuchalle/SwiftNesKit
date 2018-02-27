// 
// Utils.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

func openFile(with name: String) -> Data? {
    let currentPath = FileManager.default.currentDirectoryPath
    let testFileDir = "Tests/SwiftNesTests/TestNesFiles"
    let path = currentPath + "/" + testFileDir + "/" + name
    return FileManager.default.contents(atPath: path)
}
