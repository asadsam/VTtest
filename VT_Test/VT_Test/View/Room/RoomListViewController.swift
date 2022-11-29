//
//  RoomListViewController.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import UIKit

class RoomListViewController: UIViewController {
    
    @IBOutlet weak var m_tableView: UITableView!
    
    var m_viewModel = RoomListViewModel(service: RoomWebServiceManager())

    let m_reuseIdentifier = "RoomListTableViewCell"
    var m_dataIsLoaded = false
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_viewModel.delegate = self
        m_tableView.register(UINib(nibName: m_reuseIdentifier, bundle: nil), forCellReuseIdentifier: m_reuseIdentifier)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh") //NSAttributedString(string: "pullToRefresh".localized())
        refreshControl.addTarget(self, action: #selector(fetchRooms), for: .valueChanged)
        m_tableView.addSubview(refreshControl)
        self.title = "Rooms" //.localized();
    }

    override func viewDidAppear(_ animated: Bool) {
        if(!m_dataIsLoaded){
            fetchRooms()
        }
    }
    @objc func fetchRooms(){
        showHUD(message: "pleaseWait") //.localized())
        m_viewModel.fetchAllRooms()
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


extension RoomListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( m_viewModel.m_roomsArray?.count ?? 0);
        return m_viewModel.m_roomsArray?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: m_reuseIdentifier, for: indexPath) as! RoomListTableViewCell
        if let room = m_viewModel.m_roomsArray?[indexPath.row]{
            
            if let id = room.id {
                cell.m_titleLabel.text = "Room No. " + id
            }
            if let maxOccupancy = room.maxOccupancy {
                cell.m_subTitleLabel.text = "Max Occupancy: " + String(maxOccupancy)
            }
            
            let isoDate = room.createdAt ?? "" 
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: isoDate) {
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                
                cell.m_dateLabel.text = dateFormatter.string(from: date)
            }
            
            if room.isOccupied == true {
                cell.m_thumbnailImageView.image = UIImage.init(named: "occupied")
            }
            else {
                cell.m_thumbnailImageView.image = UIImage.init(named: "vacant")
            }
        }
        return cell
    }
}

extension RoomListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(isConnectedToInternet()){
//            guard let url = m_viewModel?.m_employeesArray?[indexPath.row].avatar else {return}
//        let detailsViewController = EmployeeDetailsViewController()
//        detailsViewController.m_viewModel.m_EmployeeLink = url
//        navigationItem.backButtonTitle = ""
//        navigationController?.pushViewController(detailsViewController, animated: true)
//        }
//        else{
//            displayActivityAlert(title: "noInternetAlert")//.localized())
//        }
    }
}
extension RoomListViewController: RoomListUpdateProtocol{
    func fetchRoomsFinishedWithSuccess() {
        DispatchQueue.main.async { [unowned self]in
            self.m_dataIsLoaded = true
            refreshControl.endRefreshing()
            hideHUD()
            self.m_tableView.reloadData()
            
        }
    }

}
