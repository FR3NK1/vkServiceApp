//
//  ViewController.swift
//  vkServicesApp

//  Created by Дмитрий Миронов on 12.07.2022.
//

import UIKit

class ServiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var services = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.startAnimating()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NetworkManager.shared.getData { response,_  in
            guard let response = response else { return }
            self.services = response
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.tableView.reloadData()
        }
        
        view.accessibilityIdentifier = "MainView"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServiceCell
        let service = services[indexPath.row]
        cell.configurate(with: service)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        guard let stringUrl: String = service.link else { return }
        
        if let url = URL(string: stringUrl) {
            UIApplication.shared.open(url)
        }
    }
    
}

