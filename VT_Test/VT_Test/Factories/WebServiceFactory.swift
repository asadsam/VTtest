//
//  WebServiceFactory.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import Foundation

class WebServiceFactory {
    
    func createEmpWebService() -> EmpWebservice {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if environment == "TEST" {
            return FakeEmpWebService()
        } else {
            return EmpWebServiceManager()
        }
    }
}
