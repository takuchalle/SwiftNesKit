// 
// Utils.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

func openFile(atPath path: String) -> Data? {
    return FileManager.default.contents(atPath: path)
}
