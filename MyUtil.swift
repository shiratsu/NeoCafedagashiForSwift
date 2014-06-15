//
//  MyUtil.swift
//  NeoCafeSagashiForSwift
//
//  Created by HIRATSUKA SHUNSUKE on 2014/06/14.
//  Copyright (c) 2014年 HIRATSUKA SHUNSUKE. All rights reserved.
//

import Foundation

class MyUtil {
    class func feedCalcLatLon(latitude:Double,longitude:Double,distance:Double) -> Array<Double> {
        
        let basedist:Double = 0.000277778
        
        let overLat:Double = latitude+(basedist*(distance/30))
        let overLon:Double = longitude+(basedist*(distance/30))
        
        let underLat:Double = latitude-(basedist*(distance/30))
        let underLon:Double = longitude-(basedist*(distance/30))
        
        
        return [underLat,underLon,overLat,overLon]
    }
}