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
    @IBOutlet weak var timerLabel: UILabel!
    
    var arr: [[Double]] = []
    var key: Int = 0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    private var mapChangedFromUserInteraction = false
//    let pawPin = UIImage(named: "paw")!

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
            zoomIn(latitude: latitude, longitude: longitude, sizeOfArr: sizeOfArr)
            key = key + 1
        }
    }


    func zoomIn(latitude: Double, longitude: Double, sizeOfArr: Int){
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapIt.setRegion(region, animated: true)
        animation(location: location)
        print("this is ")
        print(location)

    }

    
    func annotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
  
        delay(bySeconds: 0.5) {
            self.mapIt.addAnnotation(annotation)
        }
        
    }
    
    
    
//From Stack Overflow: Start
    func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
//End


    func animation(location: CLLocationCoordinate2D){
//        super.viewDidLoad(animation)
        delay(bySeconds: 1.5, dispatchLevel: .background){
            UIView.animate(withDuration: 50, delay: 0.5, animations: {
                self.annotation(location: location)
            })
        }
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
        accessData()
        mapIt.delegate = self
        self.mapIt.delegate = self
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
