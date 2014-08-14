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
    
    
    var calloutview: SMCalloutView!
    var emptyCalloutView:UIView!
    var lm: CLLocationManager!
    
    var cafeObjects = []
    var backupAry:Array<String> = []
    
    let defaultRadius:Int = 500
    let CalloutYOffset:CGFloat = 10.0
    
    @IBOutlet var mapview : GMSMapView!
    @IBOutlet var gadbnrview : GADBannerView!
                            
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "カフェ探し"
        
        calloutview = SMCalloutView()
        
        let btn:UIButton? = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as? UIButton;
        btn!.addTarget(self, action: "calloutAccessoryButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside);
        calloutview.rightAccessoryView = btn
        
        emptyCalloutView = UIView(frame:CGRectZero);
        
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
        lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        lm.requestAlwaysAuthorization()
        lm.distanceFilter = 300
        //lm.startUpdatingLocation()
        startLocation()
        
        //tmpfunc()
        
    }

    func startLocation(){
        
        lm.startUpdatingLocation()
    }
    
    func stopLocation(){
        lm.stopUpdatingLocation()
    }
    
    @IBAction func reloadLocation(sender : AnyObject) {
        //NSLog("kkkkkkk")
        
        lm.startUpdatingLocation()
    }
    @IBAction func openMenu(sender : AnyObject) {
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        
        stopLocation()
        
        var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:newLocation.coordinate.latitude,longitude:newLocation.coordinate.longitude)
        var now :GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(coordinate.latitude,longitude:coordinate.longitude,zoom:17)
        mapview.camera = now
        
        println(coordinate.latitude)
        println(coordinate.longitude)
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(NSString(format:"%f", coordinate.latitude), forKey: "lat")
        ud.setObject(NSString(format:"%f", coordinate.longitude), forKey: "lng")
        ud.setObject(NSString(format:"%f", defaultRadius), forKey: "distance")
        searchcafe(coordinate.latitude,lng:coordinate.longitude,dist:Double(defaultRadius))
        
    }
    
    func searchcafe(lat:Double,lng:Double,dist:Double){
        println("dist:\(dist)")
        let latlonAry:Array<Double> = MyUtil.feedCalcLatLon(lat,longitude: lng,distance: dist)
        
        var lat1:Double = latlonAry[0]
        var lon1:Double = latlonAry[1]
        var lat2:Double = latlonAry[2]
        var lon2:Double = latlonAry[3]
        
        
        //条件句を作成して取得
        let condAry:Array<String> = createCondDistance(lat1,underLon: lon1,overLat: lat2,overLon: lon2)
        
        let cond1:String = condAry[0]
        let cond2:String = condAry[1]
        
        let condString = "\(cond1) and \(cond2)"
        NSLog("%@",condString)
        var predicate:NSPredicate = NSPredicate(format:condString)
        
        //cafeObjects = Cafe.MR_findAll();
        cafeObjects = Cafe.MR_findAllWithPredicate(predicate);
        println(cafeObjects.count)
//        NSLog("===============================================================================================")
//NSLog("%@",cafeObjects)
        setCafeAnnotation()
        
    }
    
    
    
    func setCafeAnnotation(){
        
        
        let pinImg:UIImage = UIImage(named:"pin1.png");
        
        //set pin
        for var i=0;i < cafeObjects.count;++i {
            if backupAry.count > 0{
                
                let searchstr = cafeObjects[i].store_name
                
                var backIndex = find(backupAry, searchstr)
                if backIndex != nil {
                    continue
                }
            }
            backupAry.append(cafeObjects[i].store_name)
            
            var d_lat:Double = Double(cafeObjects[i].lat)
            var d_lng:Double = Double(cafeObjects[i].lng)
            
            let markerInfo:Dictionary<String, String> = ["url" : cafeObjects[i].url];
            
            let cafeMarker:GMSMarker = GMSMarker()
            cafeMarker.icon = pinImg
            cafeMarker.title = cafeObjects[i].store_name
            cafeMarker.position = CLLocationCoordinate2DMake(d_lat,d_lng)
            cafeMarker.appearAnimation = kGMSMarkerAnimationPop
            cafeMarker.userData = markerInfo
            cafeMarker.flat = true
            cafeMarker.draggable = true
            cafeMarker.groundAnchor = CGPointMake(0.5, 0.5)
            cafeMarker.map = mapview
            
        }
        
        if backupAry.count > 500{
            mapview.clear()
            backupAry = []
        }
        
    }
    
    
    func mapView(mapView:GMSMapView,markerInfoWindow marker:GMSMarker) -> UIView{
        
        let anchor:CLLocationCoordinate2D = marker.position
        let point:CGPoint = mapView.projection.pointForCoordinate(anchor)
        calloutview.title = marker.title
        calloutview.calloutOffset = CGPointMake(0, -CalloutYOffset)
        
        calloutview.hidden = true
        let calloutRect:CGRect = CGRect(origin:point,size:CGSizeZero)
        
        
        
        calloutview.presentCalloutFromRect(calloutRect,inView:mapView,constrainedToView:mapView,animated:true)
        
        
        return emptyCalloutView
    }
    
    
    func mapView(mapView:GMSMapView,didTapAtCoordinate coordinate:CLLocationCoordinate2D) {
        calloutview.hidden = true
    }
    

    
    func mapView(mapView:GMSMapView,didTapMarker marker:GMSMarker) -> Bool{
        mapView.selectedMarker = marker
        return true
    }
    
    /**
    *  地図の視点変更時（移動や縮尺変更）
    *
    *  @param map_view_ グーグルマップ
    *  @param position_ 位置
    */
    func mapView(mapView:GMSMapView,idleAtCameraPosition position_:GMSCameraPosition) {
        calloutview.hidden = true
        let zoom:Double = Double(position_.zoom)
        let lat:Double = Double(position_.target.latitude)
        let lng:Double = Double(position_.target.longitude)
        let distance:Double = Double(zoom)*30
        
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(NSString(format:"%f", lat), forKey: "lat")
        ud.setObject(NSString(format:"%f", lng), forKey: "lng")
        ud.setObject(NSString(format:"%f", distance), forKey: "distance")
        //tmpfunc()
        //あとはsearchcafeを呼び出すのみ
        println("idleatcameraposition")
        searchcafe(lat,lng:lng,dist:distance)
    }
    
    func calloutAccessoryButtonTapped(sender:AnyObject){
        
        if mapview.selectedMarker {
            let marker:GMSMarker = mapview.selectedMarker
            let userdata:Dictionary<String, String> = marker.userData as Dictionary<String, String>
            let url:String = userdata["url"]!
            
            let web:Web = self.storyboard.instantiateViewControllerWithIdentifier("web_board") as Web
            web.serviceUrl = url
            self.navigationController.pushViewController(web, animated: true)
            
            
            
        }
        
    }
    
    

    
    
    func createCondDistance(underLat:Double,underLon:Double,overLat:Double,overLon:Double) -> Array<String>{
        
        let latStr:String = "lat BETWEEN {\(underLat),\(overLat)}"
        let lonStr:String = "lng BETWEEN {\(underLon),\(overLon)}"
        return [latStr,lonStr]
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        
    }
    
    //戻ってきたとき
    override func viewWillAppear(animated: Bool){
        
        let ud = NSUserDefaults.standardUserDefaults()
        
    }
    
    //非表示になる直前
    override func viewWillDisappear(animated:Bool) {
        
        mapview.clear()
        cafeObjects = []
        backupAry = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        mapview.clear()
        cafeObjects = []
        backupAry = []
    }
    
    func tmpfunc(){
        let sampleTodo: Cafe = Cafe.MR_createEntity() as Cafe
        sampleTodo.address = "test"
        sampleTodo.id = 1
        sampleTodo.lat = 130.0313
        sampleTodo.lng = 130.0313
        sampleTodo.created_at = NSDate.date()
        sampleTodo.updated_at = NSDate.date()
        sampleTodo.store_name = "test"
        sampleTodo.url = "test"
        sampleTodo.log_image = "test"

        sampleTodo.managedObjectContext.MR_saveToPersistentStoreAndWait()
    }
    


}

