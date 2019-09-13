//
//  ViewController.swift
//  cover-ma-poi
//
//  Created by Fitri San on 9/11/19.
//  Copyright © 2019 com.piteli. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func centerMapWerePressed(_ sender: Any) {
    }
    
}

extension MapVC : MKMapViewDelegate {
    
}

