//
//  JsonUtility.swift
//  ContactsAppTests
//
//  Created by kbedi on 13/06/2021.
//

import Foundation

enum JsonError: Error {
	case encodingError
	case serializationError(error: Error?)
}

enum FileError: Error {
	case notFound
}

final class JsonUtility: NSObject {
	
	static func dataFromTestFile(named fileName: String) throws -> Data {
		
		let testBundle = Bundle(identifier: "com.bedi.ContactsAppTests")!
		
		guard let path = testBundle.path(forResource: fileName, ofType: "json") else {
			throw FileError.notFound
		}
		
		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
			return data
		} catch let error {
			throw JsonError.serializationError(error: error)
		}
	}
}
