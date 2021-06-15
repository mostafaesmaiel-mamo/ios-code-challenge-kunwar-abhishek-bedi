//
//  ContactViewModelTests.swift
//  ContactsAppTests
//
//  Created by kbedi on 15/06/2021.
//

import XCTest
@testable import ContactsApp
import SwiftyJSON

class ContactViewModelTests: XCTestCase {
	
	private var mockContactManager: ContactsManager!
	private var mockAdaptor: MockResponseNetworkAdaptor!
	
	override func setUpWithError() throws {
		super.setUp()
	}
	
	func testContactManagerForSearchMamoContacts() throws {
		let data = try XCTUnwrap(JsonUtility.dataFromTestFile(named: "mock_search_mamo_accounts"))
		let model = try JSONDecoder().decode(MamoAccounts.self, from: data)

		let mamoAccounts = try XCTUnwrap(model.mamoAccounts)
		let phoneContact = Contact(id: "1", firstName: "Clara", lastName: "J.")

		var contactViewModel = ContactViewModel()
		contactViewModel.configure(withPhoneContacts: [phoneContact], mamoContacts: mamoAccounts, frequentContacts: [])
		
		XCTAssertEqual(contactViewModel.numberOfItems(inSection: Section.phoneContacts.rawValue), 0)
		XCTAssertEqual(contactViewModel.numberOfItems(inSection: Section.mamoContacts.rawValue), 1)
		XCTAssertEqual(contactViewModel.numberOfItems(inSection: Section.frequentContacts.rawValue), 0)
	}
}
