//
//  TabBarViewController.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 27/11/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            UITabBar.appearance().barTintColor = .systemBackground//UIColor(hexString: themeColor) //.systemBackground
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            tabBar.tintColor = UIColor(hexString: themeColor)//.label
        } else {
            // Fallback on earlier versions
        }
           setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                                      image: UIImage) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            navController.navigationBar.prefersLargeTitles = true
            rootViewController.navigationItem.title = title
        
            navController.navigationBar.barTintColor = UIColor(hexString: themeColor)

            return navController
        }
    
    func setupVCs() {
        if #available(iOS 13.0, *) {
            viewControllers = [
                
                createNavController(for: EmployeeListViewController(), title: NSLocalizedString("Employees", comment: ""), image: UIImage(systemName: "person")!),
                createNavController(for: RoomListViewController(), title: NSLocalizedString("Rooms", comment: ""), image: UIImage(systemName: "house")!)
            ]
        } else {
            // Fallback on earlier versions
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
