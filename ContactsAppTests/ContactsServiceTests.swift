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
		
		service = ContactsService.searchAccounts(emails: [], orPhones: [])
		XCTAssertEqual(service.url?.absoluteString, "https://60adf30580a61f001733208d.mockapi.io/api/v2/accounts")

		let serviceParams = try XCTUnwrap(service.params)

		XCTAssertEqual((serviceParams["emails"] as? [String])?.count, 0 )
		XCTAssertEqual((serviceParams["phones"] as? [String])?.count, 0 )
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
		let emails = try XCTUnwrap(params["emails"]) as! [String]
		let phones = try XCTUnwrap(params["phones"]) as! [String]
		service = ContactsService.searchAccounts(emails: emails, orPhones: phones)
		let serviceParams = try XCTUnwrap(service.params)
		
		XCTAssertTrue(serviceParams.keys.contains("emails"))
		XCTAssertTrue(serviceParams.keys.contains("phones"))
				
		XCTAssertEqual((serviceParams["emails"] as? [String])?.count, 5 )
		XCTAssertEqual((serviceParams["phones"] as? [String])?.count, 5 )

		
		XCTAssertEqual(service.encoding, .json)
		XCTAssertEqual(service.method, .post)
		
	}
	
	func testFrequentContactService() {
		service = ContactsService.frequentAccounts
		XCTAssertEqual(service.url?.absoluteString, "https://60adf30580a61f001733208d.mockapi.io/api/v2/frequents")
		XCTAssertEqual(service.encoding, .url)
		XCTAssertEqual(service.method, .get)

	}
}
