//
//  TableViewController.swift
//  Map-Marker
//
//  Created by wuhaozheng on 2018/5/6.
//  Copyright © 2018 Vmeng. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var dataArray:Array<MarkCollection>?

    override func viewDidLoad() {
        super.viewDidLoad()
        let mark1=MarkCollection()
        mark1.location=CLLocationCoordinate2D(latitude: 39.992520, longitude: 116.336170)
        mark1.name="第一个点"
        mark1.details="第一个描述"
        let mark2=MarkCollection()
        mark2.location=CLLocationCoordinate2D(latitude: 39.978234, longitude: 116.352343)
        mark2.name="第二个点"
        mark2.details="第二个描述"
        dataArray=[mark1,mark2]
        
        
        let tableView=UITableView(frame: self.view.frame,style:.plain)
        
        tableView.register(NSClassFromString("CollectionTableViewCell"), forCellReuseIdentifier: "TableViewCellId")
        self.view.addSubview(tableView)
        tableView.delegate=self
        tableView.dataSource=self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return dataArray!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:CollectionTableViewCell?=tableView.dequeueReusableCell(withIdentifier: "TableViewCellId") as? CollectionTableViewCell
        if cell == nil {
            cell = CollectionTableViewCell()
        }

//        let cell:CollectionTableViewCell?=tableView.dequeueReusableCell(withIdentifier: "TableViewCellId", for: indexPath) as? CollectionTableViewCell
        let model = dataArray![indexPath.row]
        cell?.name.text=model.name
        cell?.details.text=model.details
        return cell!
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
