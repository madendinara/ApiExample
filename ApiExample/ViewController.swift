//
//  ViewController.swift
//  ApiExample
//
//  Created by Dinara on 10/1/19.
//  Copyright © 2019 Dinara Sadykova. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var result: [String] = []
    func downloadCategories() {
        let url = URL(string: "https://latest-mutual-fund-nav.p.rapidapi.com/fetchAllSchemeNames")!
        var request = try! URLRequest(url: url, method: .get)
        //request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
        request.setValue("latest-mutual-fund-nav.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.setValue("2dda5ca6b6msh44af72d4b934d5dp183515jsn1b8bd564ae97", forHTTPHeaderField: "X-RapidAPI-Key")
        //request.setValue("application/json", forHTTPHeaderField: "accept")
        
        Alamofire.request(request).responseJSON(completionHandler: { response in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let json):
                print (json)
                let array = json as! [String]
                print(array)
                self.result = array
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
        //return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)

        //cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.text = result[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        downloadCategories()
        // Do any additional setup after loading the view.
    }


}

