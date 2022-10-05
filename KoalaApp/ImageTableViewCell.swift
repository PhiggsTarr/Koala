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
            //Continue function if ModelData is not nil
            
            
            //Set name and nickname text labels to be based off JSON data
            
//            if data.modelData!.count > 0{
//                if data.modelData!.contains(".png") || data.modelData!.contains(".jpg"){
                    
                    picture.load(url: URL(string: data.modelData!)!)
                    ImageViewController.imageUrl = URL(string: data.modelData!)
                    
//                }
//            }
        }
    }
}
