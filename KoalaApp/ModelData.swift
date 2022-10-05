//
//  ModelData.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 9/19/22.
//

import Foundation

//Struct created to model JSON Data we want for our Data
struct ModelData : Codable{
    let id: String
    let type: String
    let date: String?
    let modelData: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case date = "date"
        case modelData = "data"
    }
}


