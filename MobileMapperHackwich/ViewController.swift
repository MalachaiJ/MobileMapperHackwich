//
//  ViewController.swift
//  MobileMapperHackwich
//
//  Created by Malachai Jacobs on 1/12/22.
//
import UIKit
import MapKit


//class ViewController: UIViewController, CLLocationManagerDelegate
//{
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//    currentLocation = locations[0]
//    }
//var currentLocation: CLLocation!
    class ViewController: UIViewController, CLLocationManagerDelegate
{
       
        @IBOutlet weak var mapViewB: MKMapView!
        let locationManager = CLLocationManager()
        var currentLocation: CLLocation!
        var parks: [MKMapItem] = []
       
        
        @IBAction func whenZoomButtonPressed(_ sender: UIBarButtonItem)
        {
            
            let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let center = currentLocation.coordinate
            let region = MKCoordinateRegion(center: center, span: coordinateSpan)
            mapViewB.setRegion(region, animated: true)
        }
        @IBAction func whenSearchButtonPressed(_ sender: Any)
        {
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Parks"
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            request.region = MKCoordinateRegion(center: currentLocation.coordinate, span: span)
            let search = MKLocalSearch(request: request)
            search.start { (response, error) in
            guard let response = response else { return }
            for mapItem in response.mapItems
                {
            self.parks.append(mapItem)
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapItem.placemark.coordinate
            annotation.title = mapItem.name
            self.mapViewB.addAnnotation(annotation)
            }
            }
            }
       
        
    
    override func viewDidLoad()
    {
        locationManager.requestWhenInUseAuthorization()
        mapViewB.showsUserLocation = true
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
            
        
        
        // Do any additional setup after loading the view.
    }
    

}



