//
//  EmployeesListViewModel.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import Foundation

class EmployeeListViewModel: NSObject {
    
    // dependency injection
    var service: EmpWebservice
    
    init(service: EmpWebservice) {
        self.service = service
    }
    
    weak var delegate:EmployeeListUpdateProtocol?
    var m_employeesArray : EmployeesResult?

    func fetchAllEmployees()
    {
        self.service.loadProfiles { [unowned self] data, status, error in
            
            if let data = data{
                self.m_employeesArray = convertDataToModel(data, type: EmployeesResult.self)
            }
            self.delegate?.fetchEmployeesFinishedWithSuccess()
        }
    }
}
