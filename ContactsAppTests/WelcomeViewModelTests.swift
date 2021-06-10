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
    private var userDefaults: UserDefaults!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = WelcomeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testPermissionPriming() throws {
        XCTAssertFalse(viewModel.canShowPermissionPrimingAlert)

        viewModel = WelcomeViewModel(canShowPermissionPrimingAlert: true)
        XCTAssertTrue(viewModel.canShowPermissionPrimingAlert)
    }

    func testPermissionPrimingUpdate() throws {
        XCTAssertFalse(viewModel.canShowPermissionPrimingAlert)
        
        viewModel.updateShowPermissionPrimingAlert(shouldShowAgain:true)

        XCTAssertTrue(viewModel.canShowPermissionPrimingAlert)
    }

}
