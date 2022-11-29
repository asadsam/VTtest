//
//  Employee.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import Foundation

// MARK: - Employee
struct Employee: Codable {
    let createdAt, firstName: String?
    let avatar: String?
    let lastName, email, jobtitle, favouriteColor: String?
    let id: String?
    let data: DataClass?
    let to, fromName: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let title, body, id, toID: String?
    let fromID, meetingid: String?

    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}

typealias EmployeesResult = [Employee]

protocol EmployeeListUpdateProtocol:AnyObject
{
    func fetchEmployeesFinishedWithSuccess()
}
