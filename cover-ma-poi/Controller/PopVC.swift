//
//  PopVC.swift
//  cover-ma-poi
//
//  Created by Fitri San on 9/23/19.
//  Copyright © 2019 com.piteli. All rights reserved.
//

import UIKit

class PopVC: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var popImageView: UIImageView!
    
    var passedImage : UIImage?
    
    
    func initData(forImage image : UIImage){
        self.passedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popImageView.image = passedImage
        addDoubleTap()
    }
    
    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target : self, action : #selector(PopVC.screenWasDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    @objc func screenWasDoubleTap(){
        dismiss(animated: true, completion: nil)
    }

}
