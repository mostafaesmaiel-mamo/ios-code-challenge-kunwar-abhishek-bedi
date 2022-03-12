//
//  ContactsManagerTests.swift
//  ContactsAppTests
//
//  Created by kbedi on 13/06/2021.
//

import XCTest
@testable import ContactsApp

class ContactsManagerTests: XCTestCase {
	
	private var mockContactManager: ContactsManager!
	private var mockAdaptor: MockResponseNetworkAdaptor!
	
	override func setUpWithError() throws {
		super.setUp()
	}
	
	func testContactManagerForSearchMamoContacts() throws {
		mockAdaptor = MockResponseNetworkAdaptor(fileName: "mock_search_mamo_accounts")
		mockContactManager = ContactsManager(networkAdaptor: mockAdaptor)

		mockContactManager.fetchSearchMamoContacts(emails: [], orPhones: []){ response in
			
			let firstAccount = try? XCTUnwrap(response.first)
			XCTAssertEqual(firstAccount?.publicName, "Clara J.")
		}
	}
	
	func testContactManagerForFrequentContacts() throws {
		mockAdaptor = MockResponseNetworkAdaptor(fileName: "mock_frequent_accounts")
		mockContactManager = ContactsManager(networkAdaptor: mockAdaptor)

		mockContactManager.fetchFrequentMamoContacts(onCompletion: { response in
			
			XCTAssertEqual(response.count, 5)
			
			let firstAccount = try? XCTUnwrap(response.first)
			XCTAssertEqual(firstAccount?.publicName, "Clara J.")
			
			let lastAccount = try? XCTUnwrap(response.last)
			XCTAssertEqual(lastAccount?.publicName, "Gardy .F")
		})
	}
}

