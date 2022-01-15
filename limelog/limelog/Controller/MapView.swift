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
    
    let locationManager = CLLocationManager()
    
    var isFirstTime = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        ///Asks the User for location permision
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        MapView.showsUserLocation = true
//        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        
//        view.addSubview(floatingButton)
        
        
        
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
    
    
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            MapView.setRegion(region, animated: true)
        }
    }
    
    
    ///Flaating Button
    private let floatingButton: UIButton = {

        let button = UIButton(frame: CGRect( x: 0, y: 0, width: 60, height: 60 ))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemPink
        
        return button
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 100 ,
            y: view.frame.size.height - 400,
            width: 60,
            height: 60)
    }
    
    
    
    
    //Button Actions
    
    @IBAction func recenterUserBtn(_ sender: Any) {
        
    
        
        
    }
    
    
}








//MARK: - CCLocationManagerDelegate
extension MapView: CLLocationManagerDelegate{
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        let center =  CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        if(self.isFirstTime){
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            MapView.setRegion(region, animated: true)
            
            self.isFirstTime = false
            
            
            
            
            
        }
        
    
    }
    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
