//
//  MapView.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 1/6/22.
//

import Foundation
import MapKit
import CoreLocation


class MapView: UIViewController{
    
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var annotationBtn: UIButton!
    
    
    
    struct dirtyRoute{
        let pointA: CLLocationCoordinate2D
        let pointB: CLLocationCoordinate2D
        
        init(pointA: CLLocationCoordinate2D, pointB: CLLocationCoordinate2D){
            self.pointA = pointA
            self.pointB = pointB
        }
    }
    
    ///Temporary hold point A and point B
    var loc1: CLLocationCoordinate2D?
    var loc2: CLLocationCoordinate2D?


    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100
    var previousLocation: CLLocation?
    
    ///Variable to hold boolian value to display and hide garbage btn
    var isFirstTime = true
    
    ///Store an Array of CCLocation Cordinates
    private var myAnnotations = [CLLocation]()
    
 /// Temporary hold one CCLocation from regionDidChangeAnimated delegate method
    var holdLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        MapView.delegate = self
        
        ///Checki If  Location Services is enabled 
        checkLocationServices()

        annotationBtn.isHidden = true
        
        styleMapViewUIButtons(btn, .systemPink, "plus")
        styleMapViewUIButtons(btn2, .systemGreen, "minus")
        styleMapViewUIButtons(btn3, .systemBlue, "location.fill")
        
        
    }

    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {

            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
            request.requestsAlternateRoutes = true
            request.transportType = .automobile

            let directions = MKDirections(request: request)

            directions.calculate { [unowned self] response, error in
                guard let unwrappedResponse = response else { return }
                
                //for getting just one route
                if let route = unwrappedResponse.routes.first {
                    //show on map
                    self.MapView.addOverlay(route.polyline)
                    //set the map area to show the route
                    self.MapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
                }

                //if you want to show multiple routes then you can get all routes in a loop in the following statement
                //for route in unwrappedResponse.routes {}
            }
        }
    
    ///A Function to individualty style MapView UI Buttons
    func styleMapViewUIButtons(_ btnName: UIButton,  _ btnColor:UIColor, _ systemImageString: String ){
        let image = UIImage(systemName: systemImageString, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy))
        
        btnName.backgroundColor = btnColor
        btnName.setImage(image, for: .normal)
        btnName.tintColor = .white
        btnName.setTitleColor(.white, for: .normal)
        btnName.layer.shadowRadius = 10
        btnName.layer.shadowOpacity = 1
        btnName.layer.masksToBounds = true
        btnName.layer.cornerRadius = 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.largeTitleDisplayMode = .always
        self.tabBarController?.navigationItem.title = ""
    
    }
   
    ///Display all  Annotations
    func showMyAnnotations(){
                for storeLocations in myAnnotations{
                    let annotations = MKPointAnnotation()
                    annotations.accessibilityAssistiveTechnologyFocusedIdentifiers()
                    annotations.coordinate = storeLocations.coordinate
                    annotations.index(ofAccessibilityElement: storeLocations)
                    MapView.addAnnotation(annotations)
                }
    }
    
    
    func coordToLoc(coord: CLLocationCoordinate2D) -> CLLocation{
            let getLat: CLLocationDegrees = coord.latitude
            let getLon: CLLocationDegrees = coord.longitude
            let newLoc: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
            return newLoc
        }
    
///This functions adds the current cordinate that the trash pin is hovered on
    @IBAction func addCordianatesBtn(_ sender: Any) {

///Temporary Holds Current cordintaes that the trash button hovers on
        let longitude = holdLocation.coordinate.longitude
        let latitude = holdLocation.coordinate.latitude
    
        
if loc1 == nil{
            
    Alert.showBasicAlert(on: self, with: "POINT A", message: "Was added ")
    
            loc1 = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
            
            self.myAnnotations.append(self.holdLocation)
            showMyAnnotations()
        }
        
    
  else if loc2 == nil{
        
    
    Alert.showBasicAlert(on: self, with: "POINT B", message: "Was added")
    
    
        loc2 = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        
        self.myAnnotations.append(self.holdLocation)
        showMyAnnotations()
       
    
    showRouteOnMap(pickupCoordinate: loc1!, destinationCoordinate: loc2!)

   loc1 = nil
   loc2 = nil

   annotationBtn.isHidden = true
  }else{
    
    
    
    Alert.showBasicAlert(on: self, with: "Error", message: "Couldent add points")
  }
  
    
    
  


        
        
        }

    
    
 
    
    ///Check if location Services are enabled if not prompt user to turn un location services
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setUpLocationManager()
            checkLocationAuthorization()
            //Set up your location manager
        }else{
            //Show an alert to the user leting them know they have to turn this on.
            Alert.showBasicAlert(on: self, with: "Location Services", message: "In order to use this app Location Services must be enabled")
        }
    }
    
    ///Set up location manager to use CLLocationManagerDelegate helper methods
    func setUpLocationManager(){
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestLocation()
        
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
    
        case .authorizedWhenInUse:
    //DO Map Stuff
            ///Shows users current location on a map as a blue point
            startTrackingUserLocation()
          
        case .denied:
            //Show alert instructing them how to turn on permisions
//            Alert.showBasicAlert(on: self, with: "Location Services Desabeled", message: "Please turn on Location services in setting to keep using the App")
    ///Naviagtes the user to setting in orther for them to turn on location services
            navigateTheUserToLocationSetting()
            break
        case.notDetermined:
            locationManager.requestWhenInUseAuthorization()
        break
        case .restricted:
            //Show an alert letting thme know what's up
        break
        case .authorizedAlways:
        break
        
        }}
    
    ///Center the user location
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            MapView.setRegion(region, animated: true)
        }
    }

    ///
    func startTrackingUserLocation(){
        MapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: MapView)
    }
    
    
    
    //MAP VIEW BUTTON ACTION
    @IBAction func recenterUserBtn(_ sender: Any) {
        centerViewOnUserLocation()
    }
    
    @IBAction func addAnnotationBtn(_ sender: Any) {
        
        Alert.showBasicAlert(on: self, with: "Add a dirty route", message: "Drag and press the garbage bin to add a dirty route")
        annotationBtn.isHidden = false
    }
    
    @IBAction func deleteAnnotationBtn(_ sender: Any) {
    
        Alert.showBasicAlert(on: self, with: "Determit TEST", message: "This Button will remove an Annotaion")
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation{
        let latitude = MapView.centerCoordinate.latitude
        let longitude = MapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    
    func navigateTheUserToLocationSetting(){
        let alertController = UIAlertController(title: "Alert", message: "Determit needs your exact location to start navigation", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }
               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       // Successfully navigated to settings
                   })
               }
           }
        
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           alertController.addAction(okAction)
           alertController.addAction(cancelAction)
           self.present(alertController, animated: true, completion: nil)
    }
    
}


/// Returnt the cordinates for the center location
func getCenterLocation(for MapView: MKMapView) -> CLLocation{
    
    let latitude = MapView.centerCoordinate.latitude
    let longitude =  MapView.centerCoordinate.longitude
    
    return CLLocation(latitude: latitude, longitude: longitude)
}







//MARK: - CCLocationManagerDelegate
extension MapView: CLLocationManagerDelegate{
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {return}
        
        
        let center =  CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        if(self.isFirstTime){
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)

            MapView.setRegion(region, animated: true)

            self.isFirstTime = false
        }


    }
    


    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: - CCLocationManagerDelegate
extension MapView: MKMapViewDelegate{
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        let alert = UIAlertController(title: "Has this area been clean?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            
            DispatchQueue.main.async {
           
                self.myAnnotations.removeAll()
                
                
                
            }
            
        }))
        self.present(alert, animated: true)

       

        
        
        
        
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

//        print("The region displayed by the map view just changed")
        
        ///Get the center location cordinates of the MapView
        let center = getCenterLocation(for: MapView)
        
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else{return}
        
        guard center.distance(from: previousLocation) > 1 else {return}
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks , error) in
            guard let self = self else {return}
            
            if let _ = error {
                
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
//            let streetNumber = placemark.subThoroughfare ?? ""
//            let streetName = placemark.thoroughfare ?? ""
            let description = placemark.description
//            let name = placemark.name ?? ""
  
            
            
         
            DispatchQueue.main.async { [self] in
                self.addressLabel.text = "\(description)"
                
                let longitude = placemark.location?.coordinate.latitude
                let latitude = placemark.location?.coordinate.longitude
                
                ///Store the location
                self.holdLocation = CLLocation(latitude: longitude!, longitude: latitude!)
                 
               
            
                
            }
           
        }
        
    }

    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
   
        let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.systemPink
            renderer.lineWidth = 6.0
            renderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.4)
            renderer.alpha = 0.9
        
//        guard(overlay is MKPolygon) else { return MKOverlayRenderer() }
//
//             let renderer = MKPolygonRenderer.init(polygon: overlay as! MKPolygon)
//             renderer.lineWidth = 1.0
//             renderer.strokeColor = UIColor.systemBlue
            return renderer
    }
    
}
