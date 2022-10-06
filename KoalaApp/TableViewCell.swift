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
            
            //if ModelData is not nil set labelText to be able to indent long names by having 0 number of lines
            id.numberOfLines = 0
            type.numberOfLines = 0
            date.numberOfLines = 0
            modelText.numberOfLines = 0
            
            //Set text labels to be based off JSON data
            
            id.text = data.id
            type.text = data.type
            date.text = data.date
            let modelDataCount = data.modelData?.count ?? 0
            
            if modelDataCount == 0{
                modelText.text = "Empty"
            }else{
                modelText.text = data.modelData
            }
            
            
            if let validDate = data.date{
                if !validDate.isEmpty{
                    date.text = validDate
                }
                else{
                    date.text = "Date Not Available"
                }
            }
        }
    }
    
    //Prepare cells for reuse after dequeing them
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

