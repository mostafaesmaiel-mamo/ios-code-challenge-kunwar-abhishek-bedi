//
//  ContactsServiceTests.swift
//  ContactsAppTests
//
//  Created by kbedi on 09/06/2021.
//

import XCTest
@testable import ContactsApp
import SwiftyJSON

class ContactsServiceTests: XCTestCase {

	var service: ContactsService!
	
	func testContactServiceWithEmptyParams() throws {
		
		service = ContactsService.searchAccounts(params: [:])
		XCTAssertEqual(service.url?.absoluteString, "https://60adf30580a61f001733208d.mockapi.io/api/v2/accounts")
	}
	
	func testContactServiceWithNonEmptyParams() throws {
		let jsonString = """
{
  "emails" : [
	"clara.j.hamel@yahoo.com",
	"Paul.Hamilton@gmail.com",
	"Tanya.bell@gmail.com",
	"Terrellgraham@gmail.com",
	"Yolandacaldwell@gmail.com"
  ],
  "phones" : [
	"+971545554223",
	"+971502090761",
	"+971545558080",
	"+971502060971",
	"+971502060981"
  ]
}
"""
		let params = try XCTUnwrap(JSON(parseJSON: jsonString).dictionaryObject)
		service = ContactsService.searchAccounts(params: params)
		let serviceParams = try XCTUnwrap(service.params)
		
		XCTAssertTrue(serviceParams.keys.contains("emails"))
		XCTAssertTrue(serviceParams.keys.contains("phones"))
		
		XCTAssertEqual(service.encoding, .url)
		XCTAssertEqual(service.method, .post)
		
	}
}
