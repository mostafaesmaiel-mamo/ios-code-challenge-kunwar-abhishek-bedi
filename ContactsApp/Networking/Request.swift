//
//  Request.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

/// To synchronize all requests to the network adaptor
protocol Request {
	var urlRequest: URLRequest { get }
}
