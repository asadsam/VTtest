//
//  RoomDetailsViewController.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import UIKit

class EmployeeDetailsViewController: UIViewController {

    @IBOutlet weak var m_tableView: UITableView!
    @IBOutlet weak var m_name: UILabel!
    @IBOutlet weak var m_imageView: UIImageView!

    var employee: Employee
    
    let m_reuseIdentifier = "EmployeeDetailsTableViewCell"
    
    init(employee: Employee) {
        self.employee = employee
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_tableView.register(UINib(nibName: m_reuseIdentifier, bundle: nil), forCellReuseIdentifier: m_reuseIdentifier)
        
        let f: String? = employee.firstName
        let l: String? = employee.lastName
        let fullname = [f,l]
            .compactMap { $0 }
            .joined(separator: " ")
        
        self.m_name.text = fullname
        
        m_imageView.accessibilityTraits = .image
        m_imageView.accessibilityLabel = fullname
        
        if let imageURL = employee.avatar{
            self.m_imageView.download(from: URL(string: imageURL)!, placeholder: UIImage.init(named: "person-placeholder"))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension EmployeeDetailsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: m_reuseIdentifier, for: indexPath) as! EmployeeDetailsTableViewCell
        
        cell.m_jobTitle.text = employee.jobtitle
        cell.m_email.text = employee.email
        cell.m_favoriteColor.text = employee.favouriteColor
        
        return cell
    }
}
