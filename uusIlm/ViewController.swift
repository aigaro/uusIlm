//
//  ViewController.swift
//  uusIlm
//
//  Created by Aigar on 22/02/17.
//  Copyright © 2017 Aigar. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://www.ilmateenistus.ee/ilma_andmed/xml/forecast.php").responseString { response in
            // print response as string for debugging, testing, etc.
            //print(response.result.value)
            //print(response.result.error)
            //let xmltest = SWXMLHash.parse(response.result.value!)
            let xmltest = SWXMLHash.parse(response.data!)
            
            print(xmltest["day"] )
            print(type(of: xmltest))
            
        }
            //var xmltest = SWXMLHash.parse(response.data!)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("test")   // Dispose of any resources that can be recreated.
    }

}

