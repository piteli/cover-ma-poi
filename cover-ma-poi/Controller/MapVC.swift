//
//  ViewController.swift
//  cover-ma-poi
//
//  Created by Fitri San on 9/11/19.
//  Copyright © 2019 com.piteli. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapViewBottomContraint: NSLayoutConstraint!
    @IBOutlet weak var pullUpView: UIView!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius : Double = 1000
    var screenSize = UIScreen.main.bounds
    
    var spinner : UIActivityIndicatorView?
    var progressLbl : UILabel?
    
    var flowLayout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        pullUpView.addSubview(collectionView!)
    }
    
    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target : self, action : #selector(dropPin(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func animateViewUp(){
        mapViewBottomContraint.constant = 300
        UIView.animate(withDuration : 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown(){
        mapViewBottomContraint.constant = 0
        UIView.animate(withDuration : 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    func addSpinner(){
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x : (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y : 150)
        spinner?.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        spinner?.startAnimating()
        collectionView?.addSubview(spinner!)
    }
    
    func removeSpinner(){
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
    
    func addProgressLbl(){
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (screenSize.width / 2) - 120, y: 175, width: 200, height: 40)
        progressLbl?.font = UIFont(name: "Avenir Next", size: 18)
        progressLbl?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        progressLbl?.textAlignment = .center
//        progressLbl?.text = "12/40 photo boom"
        collectionView?.addSubview(progressLbl!)
    }
    
    func addSwipe(){
        let swipe = UISwipeGestureRecognizer(target : self, action : #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }
    
    func removeProgressLbl(){
        progressLbl?.removeFromSuperview()
    }

    @IBAction func centerMapWerePressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse{
            centerMapOnUserLocation()
        }
    }
    
}

extension MapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation : annotation, reuseIdentifier : "droppablePin")
        pinAnnotation.tintColor = #colorLiteral(red: 0.9771530032, green: 0.7062081099, blue: 0.1748393774, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center : coordinate, span : MKCoordinateSpan(latitudeDelta: regionRadius, longitudeDelta: regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender : UITapGestureRecognizer){
        //drop pin on the map
        removePin()
        removeSpinner()
        removeProgressLbl()
        
        animateViewUp()
        addSwipe()
        addSpinner()
        addProgressLbl()
        let touchpoint = sender.location(in : mapView)
        print(touchpoint)
        let touchCoordinate = mapView.convert(touchpoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordinate:  touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
        let coordinateRegion = MKCoordinateRegion(center : touchCoordinate, span : MKCoordinateSpan(latitudeDelta: regionRadius, longitudeDelta: regionRadius))
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    func removePin(){
        for annotation in mapView.annotations{
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC : CLLocationManagerDelegate {
    func configureLocationServices(){
        if authorizationStatus == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }else{
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

extension MapVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of item in array
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
