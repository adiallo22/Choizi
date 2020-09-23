//
//  ServiceUploadInterfaceMock.swift
//  ChoiziTests
//
//  Created by Abdul Diallo on 9/23/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import XCTest
@testable import Choizi

class ServiceUploadInterfaceTest: XCTestCase {
    
    let sut : UploadServiceMock!

    override func setUpWithError() throws {
        sut = UploadServiceMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUploadImg_ShouldNotReturnError() {
        let exceptation = XCTestExpectation(description: "testing the upload image should pass, therefore the string should not be nil")
        sut.uploadImage(image: #imageLiteral(resourceName: "Wtfv8VY8I2RDhbQlIvSqORBAx1N2")) { result in
            switch result {
            case .success(let string):
                XCTAssertNotNil(string)
                exceptation.fulfill()
            case failure(_):
                print("")
            }
        }
        wait(for: [exceptation], timeout: 5.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
