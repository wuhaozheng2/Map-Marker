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
    var mapView:MAMapView?
    var annotations: Array<MAPointAnnotation>!
    var geodesicCoords=[CLLocationCoordinate2D]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        AMapServices.shared().apiKey = APIKey
        initMapView()
        initAnnotations()
        mapView!.setCenter(mapView!.userLocation.coordinate, animated: true)

        

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
        annotations = Array()
        
        let coordinates: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 39.992520, longitude: 116.336170),
            CLLocationCoordinate2D(latitude: 39.978234, longitude: 116.352343),
            CLLocationCoordinate2D(latitude: 39.998293, longitude: 116.348904),
            CLLocationCoordinate2D(latitude: 40.004087, longitude: 116.353915),
            CLLocationCoordinate2D(latitude: 40.001442, longitude: 116.353915),
            CLLocationCoordinate2D(latitude: 39.989105, longitude: 116.360200),
            CLLocationCoordinate2D(latitude: 39.989098, longitude: 116.360201),
            CLLocationCoordinate2D(latitude: 39.998439, longitude: 116.324219),
            CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)]
        
        for (idx, coor) in coordinates.enumerated() {
            let anno = MAPointAnnotation()
            anno.coordinate = coor
            anno.title = String(idx)
            
            annotations.append(anno)
        }
        mapView!.addAnnotations(annotations)
        mapView!.showAnnotations(annotations, edgePadding: UIEdgeInsetsMake(20, 20, 20, 20), animated: true)
        mapView!.selectAnnotation(annotations.first, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

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
            
            let idx = annotations.index(of: annotation as! MAPointAnnotation)
            annotationView!.pinColor = MAPinAnnotationColor(rawValue: idx! % 3)!
            
            return annotationView!
        }
        
        return nil
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

