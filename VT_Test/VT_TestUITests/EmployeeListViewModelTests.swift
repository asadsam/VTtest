//
//  EmployeeListViewModelTests.swift
//  VT_TestTests
//
//  Created by asad on 29/11/2022.
//

import XCTest
@testable import VT_Test

class EmployeeListViewModelTests: XCTestCase {

    var sut: EmployeeListViewModel!
    var empWebServiceManagerSpy: EmpWebserviceSpy!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        empWebServiceManagerSpy = EmpWebserviceSpy()
        sut = EmployeeListViewModel(service:empWebServiceManagerSpy)
    }

    class EmpWebserviceSpy: FakeEmpWebService {
        
        var loadProfilesCalled = false
                        
        //var mockData = [Employee(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Maggie", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Brekke", email: "Crystel.Nicolas61@hotmail.com", jobtitle: "Future Functionality Strategist", favouriteColor: "pink", id: "1", data: DataClass(title: "", body: "", id: "", toID: "", fromID: "", meetingid: ""), to: "", fromName: ""),Employee(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Maggie", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Brekke", email: "Crystel.Nicolas61@hotmail.com", jobtitle: "Future Functionality Strategist", favouriteColor: "pink", id: "1", data: DataClass(title: "", body: "", id: "", toID: "", fromID: "", meetingid: ""), to: "", fromName: "")]
        
        override func loadProfiles(completionHandler: @escaping CompletionHandlerWS) {
            
                loadProfilesCalled = true
            }
        }
    
    // MARK: - Tests
    func testShouldLoadProfilesOnDidAppear() {
        
        // Given
        sut.service = empWebServiceManagerSpy
        
        // When
        sut.service.loadProfiles { data, status, error in
            
        }
        
        // Then
        XCTAssertTrue(
            empWebServiceManagerSpy.loadProfilesCalled,
          "fetchMedia() should ask the interactor to load the media"
        )
    }
    
}
