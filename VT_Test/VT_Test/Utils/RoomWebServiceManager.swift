//
//  RoomWebServiceManager.swift
//  VT_Test
//
//  Created by asad on 28/11/2022.
//

import Foundation

//MARK: room web services
protocol RoomWebService {
    typealias CompletionHandlerWS = (Data?, Bool, Error?) -> Void

    func loadRooms(completionHandler: @escaping CompletionHandlerWS)
}

class RoomWebServiceManager: RoomWebService {
    
    func loadRooms(completionHandler: @escaping CompletionHandlerWS) {
        
        WebserviceRequestResponseManager.sharedInstance.executeGetRequest(url: String(format: baseURL, endPoint.rooms.rawValue)) {data, response, error, status in
            
            completionHandler(data,status,error)
        }
    }
}
