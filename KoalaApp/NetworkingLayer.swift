//
//  NetworkingLayer.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 9/19/22.
//

import Foundation
import UIKit

class NetworkingLayer{
    
    func loadData() async -> [ModelData] {
        
        //Makes Network Call
        let request = URLRequest(url: URL(string: "https://koala-coding-challenge.s3.amazonaws.com/ios/challenge-data.json")!)
        
        do {
            //Do try-catch to load data asynchronously and add elements to our results array
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let results = try JSONDecoder().decode([ModelData].self, from: data)
            
            
            
            return results
            
            //If we come arcoss an error then print message in console
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch {
            print("Error: Failed to fetch")
        }
        
        return []
    }
    
}


