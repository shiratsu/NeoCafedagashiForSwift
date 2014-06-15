//
//  ViewController.swift
//  NeoCafeSagashiForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/06/05.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    
    var calloutview: SMCalloutView?
    var lm: CLLocationManager!
    let defaultRadius = 500
    
    @IBOutlet var mapview : GMSMapView
    @IBOutlet var gadbnrview : GADBannerView
                            
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "カフェ探し"
        let leftbtn: UIBarButtonItem = UIBarButtonItem()
        
        
        gadbnrview.adUnitID = "ca-app-pub-8789201169323567/1907251504";
        gadbnrview.rootViewController = self
        
        self.view.addSubview(gadbnrview);
        let request:GADRequest = GADRequest();
        gadbnrview.loadRequest(request)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        mapview.myLocationEnabled = true
        mapview.delegate = self
        
        lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestAlwaysAuthorization()
        lm.distanceFilter = 300
        //lm.startUpdatingLocation()
        startLocation()
        
        
        
    }

    func startLocation(){
        
        lm.startUpdatingLocation()
    }
    
    func stopLocation(){
        lm.stopUpdatingLocation()
    }
    
    @IBAction func reloadLocation(sender : AnyObject) {
        
        lm.startUpdatingLocation()
    }
    @IBAction func openMenu(sender : AnyObject) {
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        //NSLog("bbb")
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:newLocation.coordinate.latitude,longitude:newLocation.coordinate.longitude)
        var now :GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(coordinate.latitude,longitude:coordinate.longitude,zoom:17)
        mapview.camera = now
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(NSString(format:"%f", coordinate.latitude), forKey: "lat")
        ud.setObject(NSString(format:"%f", coordinate.longitude), forKey: "lng")
        
    }
    
    func searchcafe(lat:Double,lng:Double,dist:Double){
        
        let latlonAry:Array<Double> = MyUtil.feedCalcLatLon(lat,longitude: lng,distance: dist)
        
        var lat1:Double = latlonAry[0]
        var lon1:Double = latlonAry[1]
        var lat2:Double = latlonAry[2]
        var lon2:Double = latlonAry[3]
        
        let condAry:Array<String> = createCondDistance(lat1,underLon: lon1,overLat: lat2,overLon: lon2)
        
    }
    
    
    func createCondDistance(underLat:Double,underLon:Double,overLat:Double,overLon:Double) -> Array<String>{
        
        let latStr:String = "lat BETWEEN {\(String(underLat)),\(String(overLat))}"
        let lonStr:String = "lon BETWEEN {\(String(underLon)),\(String(overLon))}"
        return [latStr,lonStr]
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        //NSLog("ccc")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

