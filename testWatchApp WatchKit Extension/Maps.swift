
//
//  Maps.swift
//  testWatchApp WatchKit Extension
//
//  Created by De biasi, Anna (A.) on 7/26/18.
//  Copyright © 2018 Low, Makena (M.). All rights reserved.
//

import WatchConnectivity
import WatchKit
import Foundation
import CoreLocation
import UIKit
import MapKit

class Maps: WKInterfaceController, CLLocationManagerDelegate {
   
    // creates instance of location
    let locationManager:CLLocationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    // initializes parking location coordinates
    var parkingLocation : Array<Double> = [37.424739, -122.109551]
    
    @IBAction func mapView() {

        // gets coordinates in degress
        let latitude:CLLocationDegrees =  parkingLocation[0]
        let longitude:CLLocationDegrees =  parkingLocation[1]
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        // created the specifications of driving directions and view
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault, MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)] as [String : Any]
        
        // setting placemoarks and an array between two locations
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem2 = MKMapItem(placemark: placemark)
        let mapItem1 = MKMapItem.forCurrentLocation()
        mapItem2.name = "Parked Car"
        let mapItems = [mapItem1, mapItem2]

        // opens up the maps with directions and locations
        MKMapItem.openMaps(with: mapItems, launchOptions: options)
      
  }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // stors the data for if app is closed
        UserDefaults.standard.set(parkingLocation, forKey: "parking")
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // requesting authorization for location use
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
