//
//  WelcomeViewModelTests.swift
//  ContactsAppTests
//
//  Created by kbedi on 10/06/2021.
//

import XCTest
@testable import ContactsApp

class WelcomeViewModelTests: XCTestCase {

    var viewModel:WelcomeViewModel!
    private var userDefaults: MamoDefaults!

    override func setUpWithError() throws {
        super.setUp()
		userDefaults = MamoDefaults(suiteName: #file)

		viewModel = WelcomeViewModel(defaults: userDefaults)
    }

    override func tearDownWithError() throws {
        viewModel = nil
		userDefaults.removePersistentDomain(forName: #file)
		userDefaults.removeSuite(named: #file)
    }

    func testPermissionPriming() throws {
		userDefaults.canAccessContacts = false
        XCTAssertTrue(viewModel.shouldShowPermissionPrimingAlert)
    }

}
