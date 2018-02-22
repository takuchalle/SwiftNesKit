// 
// NesFile.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

struct NesFile {
	let Program: Data
	let Character: Data

	let programSizeUnit = 16 * 1024
	let characterSizeUnit = 8 * 1024

	static let headerSize = 4
	static func checkHeader(_ header: Data) -> Bool {
		return (header[0] == 0x4E &&
			header[1] == 0x45 &&
			header[2] == 0x53 &&
			header[3] == 0x1A)
	}
	init?(_ data: Data) {
		guard NesFile.checkHeader(data.subdata(in: 0..<NesFile.headerSize)) else {
			return nil
		}
		let programSize = Int(data[4]) * programSizeUnit
		let characterSize = Int(data[5]) * characterSizeUnit

		Program = data.subdata(in: 16..<programSize)
		Character = data.subdata(in: 16..<characterSize)
	}
}
