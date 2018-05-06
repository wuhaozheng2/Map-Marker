//
//  ViewController.swift
//  Map-Marker
//
//  Created by wuhaozheng on 2018/5/4.
//  Copyright © 2018 Vmeng. All rights reserved.
//

import UIKit
let APIKey="b4383807b216ff5f8bb621eb83742507"




class ViewController: UIViewController,MAMapViewDelegate {
    var selectedAnnotation:MAPointAnnotation?
    var mapView:MAMapView?
    var annotations: Array<MAPointAnnotation>!
    var geodesicCoords=[CLLocationCoordinate2D]()
    var selectedLocation:CLLocationCoordinate2D?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        AMapServices.shared().apiKey = APIKey
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
        let pointAnnotation = MAPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)
        pointAnnotation.title = "方恒国际"
        pointAnnotation.subtitle = "阜通东大街6号"
        mapView!.addAnnotation(pointAnnotation)
        
        
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

