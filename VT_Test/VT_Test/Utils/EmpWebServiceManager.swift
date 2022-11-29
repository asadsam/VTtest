//
//  WebService.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import Foundation

//MARK: employee web services

protocol EmpWebservice {
    typealias CompletionHandlerWS = (Data?, Bool, Error?) -> Void

    func loadProfiles(completionHandler: @escaping CompletionHandlerWS)
}

// can be used while testing by providing some mock data
class FakeEmpWebService: EmpWebservice {
    func loadProfiles(completionHandler: @escaping CompletionHandlerWS) {
        
    }
}

class EmpWebServiceManager: EmpWebservice {
    
    func loadProfiles(completionHandler: @escaping CompletionHandlerWS) {
        
        WebserviceRequestResponseManager.sharedInstance.executeGetRequest(url: String(format: baseURL, endPoint.people.rawValue)) {data, response, error, status in
            
            completionHandler(data,status,error)
        }
    }
}
