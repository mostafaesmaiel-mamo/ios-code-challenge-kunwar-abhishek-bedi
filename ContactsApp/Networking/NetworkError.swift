//
//  NetworkError.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//
import Foundation

/// Network error networking
enum NetworkError: Error {
	
	/// Data was expected, but no data was present in the response.
	case noData					/// no data was present in the response
	case decodingError(Error) 	/// Error in  decoding the data.
	case otherNetworkingError(Error) /// Other Error
}
