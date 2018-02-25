// 
// NesFile.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

fileprivate let headerSize = 16
fileprivate let magicSize = 4

// MagicCode is placed in top of header
fileprivate func checkMagic(_ magic: Data) -> Bool {
	return (magic[0] == 0x4E &&
            magic[1] == 0x45 &&
            magic[2] == 0x53 &&
            magic[3] == 0x1A)
}

struct NesFile {
	let Program: Data
	let Character: Data

	private let programSizeUnit = 16 * 1024
	private let characterSizeUnit = 8 * 1024

	init?(_ data: Data) {
		guard checkMagic(data.subdata(in: 0..<magicSize)) else {
			return nil
		}
		let programSize = Int(data[4]) * programSizeUnit
		let characterSize = Int(data[5]) * characterSizeUnit

        let programBottom = headerSize + programSize
		Program = data.subdata(in: headerSize..<programBottom)
		Character = data.subdata(in: programBottom..<(programBottom + characterSize))
	}
}
