//
//  KoalaAppTests.swift
//  KoalaAppTests
//
//  Created by Kevin Tarr on 10/5/22.
//

import XCTest
@testable import KoalaApp

class KoalaAppTests: XCTestCase {

    
    func testNetworkCall() async{
        
        //Makes network call and returns true if we get correct data back
        var model: [ModelData] = []
        model = await NetworkingLayer().loadData()
        
        //Checks to see if we get data at all
        XCTAssertTrue(model.count > 0)
        
        //Checks to see if we get an id property
        XCTAssertTrue(model[0].id.count > 0)
        
        //Checks to see if we get a type property
        XCTAssertTrue(model[0].type.count > 0)
        
        //Checks to see if we get a data property
        XCTAssertTrue(model[0].modelData!.count > 0)
        
        //Checks to see if we get a date property
        XCTAssertTrue(model[0].date!.count > 0)
        
    }
    
}
