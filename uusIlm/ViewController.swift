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

var ilm = ilmaAndmed()




class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://www.ilmateenistus.ee/ilma_andmed/xml/forecast.php").responseString { response in
            let xmltest = SWXMLHash.parse(response.data!)
            //kuupäevi saab muuta [0] nendes sulgudes
            
            
            ilm.tempMin_day = Int(xmltest["forecasts"]["forecast"][0]["day"]["tempmin"].element!.text!)!
            ilm.tempMax_day = Int(xmltest["forecasts"]["forecast"][0]["day"]["tempmax"].element!.text!)!
            ilm.ilmTekst_day = xmltest["forecasts"]["forecast"][0]["day"]["text"].element!.text!
            
            ilm.tempMin_night = Int(xmltest["forecasts"]["forecast"][0]["night"]["tempmin"].element!.text!)!
            ilm.tempMax_night = Int(xmltest["forecasts"]["forecast"][0]["night"]["tempmax"].element!.text!)!
            ilm.ilmTekst_night = xmltest["forecasts"]["forecast"][0]["night"]["text"].element!.text!
            
           
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_min.append(Int( elem["speedmin"].element!.text! )!) }
          
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_max.append(Int(elem["speedmax"].element!.text! )!) }
            
            self.Day_Temp.text = "Päev \(ilm.tempMin_day) to \(ilm.tempMax_day) C"
            self.Night_Temp.text = "Öö \(ilm.tempMin_night) to \(ilm.tempMax_night) C"
            self.Day_Text = 
            //print(ilm.rida_max.max()!)
            //print(ilm.rida_max.min()!)
                //!.allAttributes)
            //print(type(of: xmltest))
            //ilm.ilmTekst_night = xmltest["forecasts"]["forecast"][0]["day"]["text"].element!.text!
            //print(xmltest["forecasts"]["forecast"][0]["day"]["text"].element!.text)
            //print(type(of: ilm.ilmTekst_night))
           //
            
            
        }
            //var xmltest = SWXMLHash.parse(response.data!)
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
         // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var Day_Temp: UILabel!
    @IBOutlet weak var Night_Temp: UILabel!
    @IBOutlet weak var Day_Text: UILabel!
    @IBOutlet weak var Night_Text: UILabel!


}

