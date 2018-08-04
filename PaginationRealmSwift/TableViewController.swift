//
//  TableViewController.swift
//  PaginationRealmSwift
//
//  Created by Duc Ngo on 8/4/18.
//  Copyright © 2018 Duc Ngo. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class TableViewController: UITableViewController {
  var isDataLoading:Bool=false
  var pageNo:Int=1
  var limit:Int=20
  var didEndReached:Bool=false
  var dogs = [Dog]()
    override func viewDidLoad() {
        super.viewDidLoad()
      dogs = Dog.filter(conditions: nil, page: pageNo, limit: limit) ?? []
      tableView.reloadData()

//      let realm = try! Realm()
//      for index in 1...10000 {
//        try! realm.write {
//          let dog = Dog()
//          dog.id = index
//          dog.name = "Dog \(index)"
//          realm.add(dog)
//        }
//      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dogs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = dogs[indexPath.row].name
        return cell
    }
  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
    print("scrollViewWillBeginDragging")
    isDataLoading = false
  }
  
  
  
  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    print("scrollViewDidEndDecelerating")
  }
  //Pagination
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    print("scrollViewDidEndDragging")
    if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
    {
      if !isDataLoading{
        isDataLoading = true
        pageNo += 1
        if let arr = Dog.filter(conditions: nil, page: pageNo, limit: limit) {
          dogs += arr
        }
        tableView.reloadData()
        isDataLoading = false
      }
    }
    
    
  }
}
