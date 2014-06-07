//
//  ViewController.swift
//  NeoCafeSagashiForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/06/05.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GMSMapViewDelegate {
    
    
    var calloutview: SMCalloutView?
    var lm: CLLocationManager?
    
    @IBOutlet var mapview : GMSMapView
    @IBOutlet var gadbnrview : GADBannerView
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapview.myLocationEnabled = true
        mapview.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

