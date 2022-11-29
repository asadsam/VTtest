//
//  Room.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import Foundation

// MARK: - ItunesResultElement
struct Room: Codable {
    let createdAt: String?
    let isOccupied: Bool?
    let maxOccupancy: Int?
    let id: String?
}

typealias RoomsResult = [Room]

protocol RoomListUpdateProtocol:AnyObject
{
    func fetchRoomsFinishedWithSuccess()
}
