//
//  AskLocationInfoView.swift
//  Map-Marker
//
//  Created by wuhaozheng on 2018/5/7.
//  Copyright © 2018 Vmeng. All rights reserved.
//

import UIKit

class AskLocationInfoView: UIViewController {
    var selectedLocation:CLLocationCoordinate2D?
    var textFieldMain:UITextField?
    var textFieldSub:UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.gray
        textFieldMain=UITextField(frame: CGRect(x: 20, y: 30, width: 200, height: 20))
        textFieldSub=UITextField(frame: CGRect(x: 20, y: 50, width: 200, height: 20))
        let buttonSure=UIButton(frame: CGRect(x: 20, y: 70, width: 50, height: 20))
//        buttonSure=UIButton(type: UIButtonType.system)
        buttonSure.setTitle("保存", for: .normal)
        textFieldMain?.borderStyle=UITextBorderStyle.roundedRect
        textFieldSub?.borderStyle=UITextBorderStyle.roundedRect
        textFieldMain?.placeholder="请输入地点名"
        textFieldSub?.placeholder="请输入地点描述"
        self.view.addSubview(textFieldMain!)
        self.view.addSubview(textFieldSub!)
        self.view.addSubview(buttonSure)
        buttonSure.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func tapped(){
        self.dismiss(animated: true, completion: nil)
        let filePath:String = NSHomeDirectory() + "/Documents/data.plist"
        let NSarrayFromPlist:NSArray? = NSArray(contentsOfFile: filePath)
        var arrayFromPlist:[String] = NSarrayFromPlist as! [String]
        arrayFromPlist.append=[selectedLocation:CLLocationCoordinate2D,textFieldMain?.text:String,textFieldSub?.text:String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
