//
//  ViewController.swift
//  Map-Marker
//
//  Created by wuhaozheng on 2018/5/4.
//  Copyright © 2018 Vmeng. All rights reserved.
//

import UIKit
let APIKey="b4383807b216ff5f8bb621eb83742507"
let filePath:String = NSHomeDirectory() + "/Documents/data.plist"




class ViewController: UIViewController,MAMapViewDelegate {
    var selectedAnnotation:MAPointAnnotation?
    var mapView:MAMapView?
    var annotations: Array<MAPointAnnotation>!
    var geodesicCoords=[CLLocationCoordinate2D]()
    var selectedLocation:CLLocationCoordinate2D?
    let fileManager = FileManager()

    var dataArray=Array<Dictionary<String, Any>>()
//    var dataArray=[(CLLocationCoordinate2D,String,String)]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        AMapServices.shared().apiKey = APIKey
        initDataFile()
        initMapView()
        initAnnotations()
        
        //显示右下角加号按钮
        let floaty = Floaty()
        floaty.addItem(title:"查看Mark集", handler: { item in
            self.present(TableView(), animated: true, completion: nil)
        })
        floaty.addItem(title:"Mark选中地点", handler: { item in
                self.alertForLocatinInfo(selectedLocation:self.selectedLocation!)
        })
        floaty.addItem(title:"刷新地图", handler: { item in
            self.initAnnotations()
        })
        self.view.addSubview(floaty)


        

        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    func initMapView(){
        AMapServices.shared().enableHTTPS = true
        mapView=MAMapView(frame:self.view.bounds)
        let compx=self.view.bounds.width-mapView!.compassSize.width-5
        let scalex=mapView!.scaleSize.width
        let scaley=self.view.bounds.height - mapView!.scaleSize.height-15
        let compy=UIApplication.shared.statusBarFrame.height
        mapView!.compassOrigin = CGPoint(x: compx, y: compy)
        mapView!.scaleOrigin = CGPoint(x: scalex, y: scaley)
        
        //是否开启路况显示
        mapView!.isShowTraffic = false
        mapView!.isShowsUserLocation = true
        mapView!.userTrackingMode = MAUserTrackingMode.follow
        mapView!.setZoomLevel(15, animated: true)

        
        mapView!.delegate=self
        


        self.view.addSubview(mapView!)
    }
    
    
    func initAnnotations() {
        mapView?.removeAnnotations(annotations)
//        if fileManager.fileExists(atPath: filePath)==true {
//            dataArray = NSArray(contentsOfFile: filePath)! as! [(CLLocationCoordinate2D,String,String)]
//        }
        annotations = Array()
//        var pointAnnotation=[Any]()
        let dataArray=NSArray(contentsOfFile: filePath)
//        dataArray=[(CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792),"first test","first sub"),(CLLocationCoordinate2D(latitude: 40.979590, longitude: 116.352792),"second test","second sub")]
//        dataArray=[["locationLatitude":39.979590,"locationLongitude":116.352792,"main":"first test","sub":"first sub"],["locationLatitude":40.979590,"locationLongitude":116.352792,"main":"second test","sub":"second sub"]]
        var i=0
        for n in dataArray! {
            let anno=MAPointAnnotation()
//            anno.coordinate.latitude=n["locationLatitude"] as! CLLocationDegrees
//            anno.coordinate.longitude=n["locationLongitude"] as! CLLocationDegrees
//            anno.title=n["main"] as! String
//            anno.subtitle=n["sub"] as! String
            anno.coordinate.latitude=(n as! Dictionary<String, Any>)["locationLatitude"] as! CLLocationDegrees
            anno.coordinate.longitude=(n as! Dictionary<String, Any>)["locationLongitude"] as! CLLocationDegrees
            anno.title=(n as! Dictionary<String, Any>)["main"] as! String
            anno.subtitle=(n as! Dictionary<String, Any>)["sub"] as! String
            annotations.append(anno)
            i=i+1
            
        }
        for i in annotations {
            mapView!.addAnnotation(i)
        }


//        let pointAnnotation = MAPointAnnotation()
//        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)
//        pointAnnotation.title = "方恒国际"
//        pointAnnotation.subtitle = "阜通东大街6号"
//        mapView!.addAnnotation(pointAnnotation)
        
        
    }
    
    //提示输入地点信息
    func alertForLocatinInfo(selectedLocation:CLLocationCoordinate2D) {
        let askLocationInfoView=AskLocationInfoView()
        askLocationInfoView.selectedLocation=selectedLocation
        self.present(askLocationInfoView,animated: true,completion: nil)
        
    }
    
    //收藏已选中地点
    func markLocation(){}
    
    //删除之前可能增加过的已选地点标志并将点击的地点显示在地图上
    func addSlectedLocation(selectedLocation:CLLocationCoordinate2D) {
        
        mapView!.removeAnnotation(selectedAnnotation)
        selectedAnnotation=MAPointAnnotation()
        selectedAnnotation?.coordinate=selectedLocation
        mapView!.addAnnotation(selectedAnnotation)

    }
    
    func initDataFile() {
        let exist = fileManager.fileExists(atPath: filePath)
        if exist == false {

//            var dataArray=Array<Dictionary<Int, Any>>()

             dataArray=[["locationLatitude":39.979590,"locationLongitude":116.352792,"main":"first test","sub":"first sub"],["locationLatitude":40.979590,"locationLongitude":116.352792,"main":"second test","sub":"second sub"]]
//            let dataArray=[(CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792),"first test","first sub"),(CLLocationCoordinate2D(latitude: 40.979590, longitude: 116.352792),"second test","second sub")]
//            print(dataArray)
            NSArray(array: dataArray).write(toFile: filePath, atomically: true)
//            let array = NSArray(contentsOfFile: filePath)
//            print(array)
            


//            NSKeyedArchiver.archiveRootObject(dataArray, toFile: filePath)
//            dataArray(toFile: filePath, atomically: true)
   //         fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
            
        }
    }
    
    
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    
    
    
    
    
    //协议部分

    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
            annotationView!.pinColor = MAPinAnnotationColor(rawValue: 1)!
            
            
            return annotationView!
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didSingleTappedAt coordinate: CLLocationCoordinate2D) {
        selectedLocation=coordinate
        addSlectedLocation(selectedLocation: selectedLocation!)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

