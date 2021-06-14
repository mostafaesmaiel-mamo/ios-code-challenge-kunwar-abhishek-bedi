//
//  ContactsManagerTests.swift
//  ContactsAppTests
//
//  Created by kbedi on 13/06/2021.
//

import XCTest
@testable import ContactsApp
import SwiftyJSON

class ContactsManagerTests: XCTestCase {
	
	private var mockContactManager: ContactsManager!
	private var mockAdaptor: MockResponseNetworkAdaptor!
	
	override func setUpWithError() throws {
		super.setUp()
		mockAdaptor = MockResponseNetworkAdaptor(fileName: "mock_search_mamo_accounts")
		mockContactManager = ContactsManager.init(networkAdaptor: mockAdaptor)
	}
	
	func testContactManagerForSearchMamoContacts() throws {
		
		mockContactManager.fetchSearchMamoContacts(emails: [], orPhones: []){ result in
			switch result {
				case .success(let response):
					
					let firstAccount = try? XCTUnwrap(response.first)
					XCTAssertEqual(firstAccount?.publicName, "Clara J.")
					
				case .failure:
					XCTFail("Test should have passed")
			}
		}
	}
}

