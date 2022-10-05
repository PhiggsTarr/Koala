//
//  TableViewCell.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 9/19/22.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    //Outlets for tableviewCell elements based off of JSON Data
    
    @IBOutlet var id: UILabel!
//    @IBOutlet weak var imgData: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet weak var modelText: UILabel!
    
    //Check to see if Model Data is valid
    var data : ModelData? {
        didSet {
            //if ModelData is nil exit function at return line 25
            guard let data = data else {
                return
            }
            
            if data.type == "other" {
                print("N \(String(describing: data.modelData))")
                return }
            
            print(data.type)
            //Continue function if ModelData is not nil
            
            //if ModelData is not nil set labelText to be able to indent long names by having 0 number of lines
            id.numberOfLines = 0
            type.numberOfLines = 0
            date.numberOfLines = 0
            modelText.numberOfLines = 0
            
            //Set name and nickname text labels to be based off JSON data
            
            id.text = data.id
            type.text = data.type
            date.text = data.date
            modelText.text = data.modelData
            
//            if type.text == "image"{
//                 if data.modelData!.count > 0{
//                     if data.modelData!.contains(".png") || data.modelData!.contains(".jpg"){
//                         print(data.modelData!)
//
//                         imgData.load(url: URL(string: data.modelData!)!)
//                     }
//                     else{
//                         //imgData.image = #imageLiteral(resourceName: "image-not-found copy.jpeg")
//                     }
//                 }
//                imgData.load(url:  URL(string: data.imgData ?? <#default value#>))
////                Task{
//                    await
                        
                       // self?.activityIndicator.stopAnimating()
//                    }
//            else{
//                imgData.image = #imageLiteral(resourceName: "image-not-found copy.jpeg")
//            }
            
            if let validDate = data.date{
                if !validDate.isEmpty{
                    date.text = validDate
                }
                else{
                    date.text = "Date Not Available"
                }
            }
            
         //   self.accessibilityIdentifier = data.name
            //Check to see if URL is valid before animating the activity indicator
//            if let url = URL(string: data.data) {
//                activityIndicator.startAnimating()
//                
//                Task{
//                    await imgData.load(url:  url) {[weak self] in
//                        
//                        self?.activityIndicator.stopAnimating()
//                    }
//                }
//            }
        }
    }
    
    //Prepare cells for reuse after dequeing them
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

