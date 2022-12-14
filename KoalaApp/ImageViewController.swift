//
//  PictureViewController.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 10/2/22.
//

import Foundation
import UIKit

class PictureViewController : UIViewController{
    
    @IBOutlet weak var modelImage: UIImageView!
    
    static var imageUrl : URL!
    
    override func viewDidLoad() {
        modelImage.load(url: PictureViewController.imageUrl)
    }
}
