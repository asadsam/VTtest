//
//  EmployeeListViewController.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var m_tableView: UITableView!
    
    var m_viewModel = EmployeeListViewModel(service: WebServiceFactory().createEmpWebService())

    let m_reuseIdentifier = "EmployeeListTableViewCell"
    var m_dataIsLoaded = false
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_viewModel.delegate = self
        m_tableView.register(UINib(nibName: m_reuseIdentifier, bundle: nil), forCellReuseIdentifier: m_reuseIdentifier)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh") //NSAttributedString(string: "pullToRefresh".localized())
        refreshControl.addTarget(self, action: #selector(fetchEmployees), for: .valueChanged)
        m_tableView.addSubview(refreshControl)
        self.title = "Employees" //.localized();
    }

    override func viewDidAppear(_ animated: Bool) {
        if(!m_dataIsLoaded){
            fetchEmployees()
        }
    }
    @objc func fetchEmployees(){
        showHUD(message: "pleaseWait") //.localized())
        m_viewModel.fetchAllEmployees()
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


extension EmployeeListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( m_viewModel.m_employeesArray?.count ?? 0);
        return m_viewModel.m_employeesArray?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: m_reuseIdentifier, for: indexPath) as! EmployeeListTableViewCell
        if let employee = m_viewModel.m_employeesArray?[indexPath.row]{
            
            let f: String? = employee.firstName
            let l: String? = employee.lastName
            
            cell.m_titleLabel.text = [f,l]
                .compactMap { $0 }
                .joined(separator: " ")
            
            cell.m_subTitleLabel.text = employee.lastName
            
            let isoDate = employee.createdAt ?? "" // "2020-01-22T11:22:00+0000"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: isoDate) {
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                
                cell.m_dateLabel.text = dateFormatter.string(from: date)
            }
            
            if let thumbURL = employee.avatar{
                cell.m_thumbnailImageView.download(from: URL(string: thumbURL)!, placeholder: UIImage.init(named: "person-placeholder"))
            }
        }
        return cell
    }
}

extension EmployeeListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let employee = m_viewModel.m_employeesArray?[indexPath.row] {
            
            let detailsViewController = EmployeeDetailsViewController(employee: employee)
            //detailsViewController.m_viewModel.m_EmployeeLink = url
            navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
        
    }
}
extension EmployeeListViewController: EmployeeListUpdateProtocol{
    func fetchEmployeesFinishedWithSuccess() {
        DispatchQueue.main.async { [unowned self]in
            self.m_dataIsLoaded = true
            refreshControl.endRefreshing()
            hideHUD()
            self.m_tableView.reloadData()
            
        }
    }
}

