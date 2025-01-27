//
//  ViewController.swift
//  GrailDairy
//
//  Created by David Wright on 11/16/19.
//  Copyright © 2019 David Wright. All rights reserved.
//

import UIKit

class POIsTableViewController: UIViewController, UITableViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Properties
    var pois: [POI] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPOIModalSegue" {
            if let addPOIVC = segue.destination as? AddPOIViewController {
                addPOIVC.delegate = self
            }
        } else if segue.identifier == "ShowPOIDetailSegue" {
            if let cell = tableView.indexPathForSelectedRow,
                let poiDetailVC = segue.destination as? POIDetailViewController {
                poiDetailVC.poi = pois[cell.row]
            }
        }
    }
}

extension POIsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pois.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as? POITableViewCell else { return UITableViewCell() }

        cell.poi = pois[indexPath.row]
        
        return cell
    }
}

extension POIsTableViewController: AddPOIDelegate {
    func poiWasAdded(_ poi: POI) {
        pois.append(poi)
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
