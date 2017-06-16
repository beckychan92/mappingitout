//
//  mapViewController.swift
//  mapitout
//
//  Created by Becky Chan on 6/14/17.
//  Copyright © 2017 Becky Chan. All rights reserved.



import UIKit
import SwiftyJSON
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var isZoomEnabled: Bool = true
    var isRotateEnabled: Bool = true

    @IBOutlet weak var mapIt: MKMapView!

    
    var arr: [[Double]] = []
    var key: Int = 0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    private var mapChangedFromUserInteraction = false
    var annotation: MKPointAnnotation = MKPointAnnotation()
    
    


    let location: CLLocationCoordinate2D? = nil

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
        let sizeOfArr: Int = self.arr.endIndex
        while key != sizeOfArr{
            latitude = arr[key][0]
            longitude = (arr[key][1])
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            delayWithSeconds(0.5){
                self.animation(location: location)
            
            }
            mapIt.removeAnnotations(mapIt.annotations)

            zoomIn(latitude: latitude, longitude: longitude)
            key = key + 1
        }
    }


    func zoomIn(latitude: Double, longitude: Double){
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapIt.setRegion(region, animated: true)
        animation(location: location)
        print("this is ")
        print(location)

    }
    
    func populateMap(){
        var count = 0
        while (count < self.arr.count){
            let latitude = getLatAt(index: count)
            let longitude = getLongAt(index: count)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            removePrevious()
            annotateMap(location: location)
            count += 1
        }
    }
    
    func getLatAt(index: Int) -> Double{
        return self.arr[index][0]
    }
    
    func getLongAt(index: Int) -> Double{
        return self.arr[index][1]
    }
    
    func removePrevious(){
        let allAnnotations = self.mapIt.annotations
        
        self.mapIt.removeAnnotations(allAnnotations)
    }
    
    func annotateMap(location: CLLocationCoordinate2D){
        annotation.coordinate = location
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.mapIt.addAnnotation(self.annotation)
        })
        
    }
    
    func pinMap(){
        let startLoc = self.arr[0][0]
        let startLat = self.arr[0][1]
        self.zoomIn(latitude: startLoc, longitude: startLat)
    }
    
    func annotation(location: CLLocationCoordinate2D){
        annotation.coordinate = location
  
        delayWithSeconds(0.5) {
            self.mapIt.addAnnotation(self.annotation)
        }
        
    }
    
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }


    func animation(location: CLLocationCoordinate2D){
        delayWithSeconds(1.5){
            UIView.animate(withDuration: 50, delay: 0.5, animations: {
                self.annotation(location: location)
            }
        )}
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapIt.delegate = self
        parseData()
        accessData()
        pinMap()
        populateMap()
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
