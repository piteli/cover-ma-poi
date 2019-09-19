//
//  Constants.swift
//  cover-ma-poi
//
//  Created by Fitri San on 19/09/2019.
//  Copyright © 2019 com.piteli. All rights reserved.
//

import Foundation

let API_KEY = "bbfb8989b8b3a942ee46654a40c08628"

func flickrUrl(forApiKey key : String, withAnnotation annotation : DroppablePin, andNumberOfPhotos number : Int) -> String{
    let url = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEY)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=milper_page=\(number)&format=json&nojsoncallback=1"
    return url
}


