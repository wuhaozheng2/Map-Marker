//
//  TableView.swift
//  Map-Marker
//
//  Created by wuhaozheng on 2018/5/6.
//  Copyright © 2018 Vmeng. All rights reserved.
//

import UIKit

class TableView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataMainArray:Array<String>?
    var dataSubArray:Array<String>?
    var locationArray:Array<CLLocationCoordinate2D>?
    var myCellID="TableViewCellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        let nSarrayFromPlist:NSArray  = NSArray(contentsOfFile: filePath)!
        print(nSarrayFromPlist)
        dataMainArray=[]
        dataSubArray=[]
        for n in nSarrayFromPlist {
            dataMainArray?.append((n as! Dictionary<String, Any>)["main"] as! String)
            dataSubArray?.append((n as! Dictionary<String, Any>)["sub"] as! String)
        }


       

        
        
        let tableView=UITableView(frame: self.view.frame,style:.plain)

        tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: myCellID)
        self.view.addSubview(tableView)
        tableView.delegate=self
        tableView.dataSource=self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMainArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell=tableView.dequeueReusableCell(withIdentifier: myCellID,for:indexPath)
        let cell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: myCellID)

        cell.textLabel?.text=dataMainArray?[indexPath.row]
        cell.detailTextLabel?.text=dataSubArray?[indexPath.row]

        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
