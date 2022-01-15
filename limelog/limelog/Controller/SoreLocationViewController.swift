//
//  SoreLocationViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/2/21.
//

import UIKit
import MapKit
import CoreLocation


class StoreViewController: UIViewController{
    
    //MARK: OUTLETS
    @IBOutlet weak var mapView: MKMapView!
 
    @IBOutlet weak var tableView: UITableView!
    
    //Gets the current GPS Location
    let locationManager = CLLocationManager()
    
    
    //Create an Array of Anotation
    private var allAnnotations =  [CustomAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = ""
        locationManager.delegate = self
        //Asks the user for location permision
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        
        
        //DELEGATE
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
//        annotationView.canShowCallout = true
        
        loadDummyData()
        
        showStoreLocationAnnotations(allAnnotations)
       
        //Register Custome xib file
        tableView.register(UINib(nibName: "StoreCell", bundle: nil),
                           forCellReuseIdentifier: "StoreReusableCell")
    }
    
    func loadDummyData(){
        let tdBankAnnotation = CustomAnnotation(title: "TDBank", subtitle: "Bank", coordinate: CLLocationCoordinate2D(latitude: 40.757247010371096, longitude: -73.87361031580242))
        
       let dominosPizzaAnnotation = CustomAnnotation(title: "Dominos Pizza", subtitle: "Pizza Shop", coordinate: CLLocationCoordinate2D(latitude: 40.758203946488045, longitude: -73.87422454173715))
    
        allAnnotations += [tdBankAnnotation,dominosPizzaAnnotation]
    }
    
    
    //1. CHECK IF LOCATION IS ENABLED
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationServices()
        }else{
            //Show allert letting the user know they have to turn this on
        }
    }
    
    
    //2. SET UP LOCATION MANAGER
    func setUpLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        
        case .authorizedWhenInUse:
            //Do Map StufF
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //show allert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //Show an alert letting the user knoe what's wrong
        break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    
    
    
    //Display Annotations 
    func showStoreLocationAnnotations(_ allocations: [CustomAnnotation]){

                for storeLocations in allAnnotations{
            
                    let annotations = MKPointAnnotation()
                    annotations.accessibilityAssistiveTechnologyFocusedIdentifiers()
                    annotations.title = storeLocations.title
                    annotations.subtitle = storeLocations.subtitle
                    annotations.coordinate = storeLocations.coordinate
                    annotations.subtitle = storeLocations.subtitle
                    annotations.index(ofAccessibilityElement: storeLocations)
            
                    mapView.addAnnotation(annotations)
                }
    }
    
    
    //Registers the annotation
    func registerMapAnnotationViews(){
//        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFrom)
        
        
        
        
    }
    
}


//MARK: - CLLocationManagerDelegate
extension StoreViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        let center =  CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1000,longitudinalMeters: 1000)
        
        mapView.setRegion(region, animated: true)
        
        
        //Fetch the last location optional and unwrap it
//        if let location = locations.last{
//
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//
//            print("Current Location: longitude:\(lon) latitude:\(lat)")
//
//        }
//
//        renderLocation(location)
    }
    func renderLocation(_ location: CLLocation){
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
//        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: span), animated: true)
        mapView.setRegion(region, animated: true)
 
        let userPin = MKPointAnnotation()
        userPin.title = "Current Location"
        userPin.subtitle = "your current location"
        userPin.coordinate = coordinate
        mapView.addAnnotation(userPin)
        

    }

    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - MKMAPKIT DELEGATE did select annotation
extension StoreViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        if let annotationTitle = view.annotation?.title{
            print("User pressed on Annotation: \(annotationTitle!)")
        }

        if let detailNavController = storyboard?.instantiateViewController(withIdentifier: "DetailNavController") {
            detailNavController.modalPresentationStyle = .fullScreen
            let presentationController = detailNavController.popoverPresentationController
            presentationController?.permittedArrowDirections = .any
            present(detailNavController, animated: true, completion: nil)
     }
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//
//
//
//
//    }
}
//MARK: - Table View Dara Source
extension StoreViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return allAnnotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreReusableCell", for: indexPath)
        as! StoreCell
        
        let index = allAnnotations[indexPath.row]
        cell.StoreNameLable.text = index.title
        return cell
    }
}

//MARK: - Table View Delegate
extension StoreViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        print(allAnnotations[indexPath.row].title)
    }
    
    
}
