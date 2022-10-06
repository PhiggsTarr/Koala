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
        /*
         Hello, and welcome to the Koala iOS test! The app you will be developing should be a
         quick app to showcase skills that will be valuable for the position you're applying
         for.
         Upon launch, your app should query [this] endpoint to provide content for the app.
         The format of the JSON should be self-explanatory. Develop an app with an interface
         that displays the content from the JSON filtered in the following ways:
         - All - Display all content
         - Text - Display only the text content
         - Tapping any text item should navigate to a web view that has [this] site loaded.
         - Images - Display only the image content
         - Tapping any image item should open the image in a full screen viewer. That's it!
         There are no design requirements for this application; simply use the built-in SDK
         components following design best practices. Feel free to add tests, bells, and
         whistles.
         Submission: When you complete the assignment, please compress your entire project into
         a `.zip` file and send it back to your point of contact via email. If there are any
         steps that are needed to be
         */
 
        //Makes Real Network Call
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


