//
//  CarrierAssignmentTests.swift
//  CarrierAssignmentTests
//
//  Created by Apple on 05/03/22.
//

import XCTest
@testable import CarrierAssignment

class CarrierAssignmentTests: XCTestCase {

    func testLoginApiResource_With_ValidRequest_Returns_LoginResponse() throws {
        //ARRANGE
        let request = LoginRequest(userEmail: "test@gmail.com", userPassword: "abcd1234")
        let resource = ApiHandler()
        let expectation = self.expectation(description: "ValidRequest_Returns_LoginResponse")
        
        //ACT
        resource.callLoginAPI(login: request) { (result) in
            //ASSERT
            XCTAssertNotNil(result)
            switch result {
            case .success(let authModel):
                XCTAssertEqual(authModel.user?.email, request.userEmail)
            default:
            break
//            case .failure(let error):
//                switch error {
//                case .invalidURL:
//                    self?.showAlertMessage(title: "Alert", message: "invalidURL")
//                case .unableToComplete:
//                    self?.showAlertMessage(title: "Alert", message: "unableToComplete")
//                case .invalidResponse:
//                    self?.showAlertMessage(title: "Alert", message: "invalidResponse")
//                case .invalidData:
//                    self?.showAlertMessage(title: "Alert", message: "invalidData")
//                }
                
            }
            expectation.fulfill()
        }
        
       
       
        
        waitForExpectations(timeout: 15, handler: nil)
    }
}
