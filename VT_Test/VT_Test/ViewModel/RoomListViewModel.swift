//
//  RoomListViewModel.swift
//  VT_Test
//
//  Created by asad on 28/11/2022.
//

import Foundation

class RoomListViewModel: NSObject {
    
    // dependency injection
    var service: RoomWebService
    
    init(service: RoomWebService) {
        self.service = service
    }
    
    weak var delegate: RoomListUpdateProtocol?
    var m_roomsArray : RoomsResult?

    func fetchAllRooms()
    {
        self.service.loadRooms { [unowned self] data, status, error in
            
            if let data = data{
                self.m_roomsArray = convertDataToModel(data, type: RoomsResult.self)
            }
            self.delegate?.fetchRoomsFinishedWithSuccess()
        }
    }
}
