//
//  mapViewController.swift
//  mapitout
//
//  Created by Becky Chan on 6/14/17.
//  Copyright © 2017 Becky Chan. All rights reserved.



import UIKit
import SwiftyJSON
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate {
    
    //MARK: Annotations
    //MARK: Overlays
    //MARK: Map setup
    //MARK: Life Cycle
    
    //mapView Outlet
    @IBOutlet weak var mapIt: MKMapView!
    
    //Timer for 0.5 seconds
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var arr: [[Double]] = []
    var key: Int = 0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    
    let pawPin = UIImage(named: "paw")
    

    


    func parseData(){
        if let path = Bundle.main.path(forResource: "coordinates", ofType: "json"){
            do{
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let jsonObj = try JSON(data: data)
                if jsonObj != JSON.null{
                    for(key, subJson):(String, JSON) in jsonObj{
                        arr.append(subJson.arrayObject as! [Double])
                    }
                }else {
                    print("cannot get data from file")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }else {
            print("cannot find")
        }
        
        accessData()
    }
    
    func accessData(){
        let sizeOfArr: Int = arr.endIndex
        while key != sizeOfArr{
            latitude = arr[key][0]
            longitude = (arr[key][1])
        
            //Bug: Some of the lat/long round up / down
            var geoCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
            //reset region
            let region = MKCoordinateRegionMakeWithDistance(geoCoordinates, 5000, 5000)
            mapIt.setRegion(region, animated: true)
            
            geoPointer.init(lat: latitude, long: longitude)
            
            print(region)
            key = key + 1
        }
        
    }
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
////        var view : MKPinAnnotationView
//        
//        guard let annotation = annotation as? geoPointer else {return nil}
//        
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? MKPinAnnotationView {
//            view = dequeuedView
//        }else { //make a new view
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
//        }
//        return view
//    }
//    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? geoPointer{
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier){
                print("woof")
                return view
            }else{
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier)
                view.image = #imageLiteral(resourceName: "paw")
                view.isEnabled = true
                view.canShowCallout = true
                view.leftCalloutAccessoryView = UIImageView(image: pawPin)
                print("woof woof")
                return view
            }
        }
        print("woof woof woof")
        return nil
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        accessData()
        mapIt.delegate = self
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
