//
//  ImageTableViewCell.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 10/2/22.
//

import Foundation
import UIKit

class PictureTableViewCell : UITableViewCell{
    
    @IBOutlet weak var picture: UIImageView!
    
    var data : ModelData? {
        didSet {
            //if ModelData is nil exit function at return line 25
            guard let data = data else {
                return
            }
            
            picture.load(url: URL(string: data.modelData!)!)
            picture.accessibilityIdentifier = data.id
            PictureViewController.imageUrl = URL(string: data.modelData!)
        }
    }
}
