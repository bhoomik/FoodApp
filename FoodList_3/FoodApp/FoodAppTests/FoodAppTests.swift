//
//  FoodAppTests.swift
//  FoodAppTests
//
//  Created by Jaimin Modi on 14/02/21.
//

import XCTest
@testable import FoodApp

class FoodAppTests: XCTestCase {

    private var foodService : FoodService = FoodService()

    let strURL = String(format: "%@",kBaseURL)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testParsing() {
        
        let expectation2 = expectation(description: "Parsing Succeeds")
        
        
       /* FoodService.createRequest(qMes: "", strURL: strURL, method: "GET", completionBlock: { (arg0) in
            expectation2.fulfill()
            let (output) = arg0
            print("test case output",output)
        }, andFailureBlock: { (failure) in
            XCTFail()
        })
        waitForExpectations(timeout: 600.0) { (_) -> Void in
        }*/
        
        FoodService.getWebServiceCall(kBaseURL, headerPrm: nil, isShowLoader: true, success: { (response) in
            let data = response.data
            // your failure handle
            expectation2.fulfill()
            let (output) = response
            print("test case output",response)

            
            
        }){ (ERROR) in
            XCTFail()

        }
        waitForExpectations(timeout: 600.0) { (_) -> Void in
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
