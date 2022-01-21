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
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100
    var previousLocation: CLLocation?
    
    
    var isFirstTime = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        MapView.delegate = self
        ///Checki If  Location Services is enabled 
        checkLocationServices()

        
     
        
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy))
        
        btn.backgroundColor = .systemPink
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.setTitleColor(.white, for: .normal)
        btn.layer.shadowRadius = 10
        btn.layer.shadowOpacity = 1
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 30
        
        
        
        let image2 = UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy))
        
        btn2.backgroundColor = .systemGreen
        btn2.setImage(image2, for: .normal)
        btn2.tintColor = .white
        btn2.setTitleColor(.white, for: .normal)
        btn2.layer.shadowRadius = 20
        btn2.layer.shadowColor = UIColor.darkGray.cgColor
        btn2.layer.shadowOpacity = 5
        btn2.layer.masksToBounds = true
        btn2.layer.cornerRadius = 30
        
        
        let image3 = UIImage(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .heavy))
        
        btn3.backgroundColor = .systemBlue
        btn3.setImage(image3, for: .normal)
        btn3.tintColor = .white
        btn3.setTitleColor(.white, for: .normal)
        btn3.layer.shadowRadius = 10
        btn3.layer.shadowOpacity = 1
        btn3.layer.masksToBounds = true
        btn3.layer.cornerRadius = 30
        
       

       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.navigationItem.largeTitleDisplayMode = .always
        self.tabBarController?.navigationItem.title = ""
    
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
        Alert.showBasicAlert(on: self, with: "Determit TEST", message: "This Button will add an Annotaion")
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
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        print("The region displayed by the map view just changed")
        
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
    
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
         
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
                
                
                let longitude = placemark.location?.coordinate.latitude
                let latitude = placemark.location?.coordinate.longitude
                
                print("\(longitude!)")
                print("\(latitude!)")
                
            }
            
        }
        
    }

    
}
