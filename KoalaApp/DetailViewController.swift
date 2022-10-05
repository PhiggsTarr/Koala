//
//  DetailViewController.swift
//  KoalaApp
//
//  Created by Kevin Tarr on 9/19/22.
//

import Foundation
import UIKit
import WebKit


class DetailViewController : UIViewController{
    
    @IBOutlet weak var wView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let url = URL (string: "https://koala.io/")
            let requestObj = URLRequest(url: url!)
        wView.load(requestObj)
            
        // Do any additional setup after loading the view.
    }
}
