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
            
           // print(xmltest["forecasts"]["forecast"][0].element?.attribute(by: "date")?.text)
            
           
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_min.append(Int( elem["speedmin"].element!.text! )!) }          
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_max.append(Int(elem["speedmax"].element!.text! )!) }
           
            self.Wind_Range.text = "Tuule kiirus päeval on \(ilm.rida_min.max()!) kuni \(ilm.rida_max.max()!) m/s"
            
            self.Day_Temp.text = "Päev \(ilm.tempMin_day) to \(ilm.tempMax_day) °C"
            self.Night_Temp.text = "Öö \(ilm.tempMin_night) to \(ilm.tempMax_night) °C"
            
            switch Int(ilm.tempMax_day) {
            case -100 ... -1:
                self.Day_Text.text = "Külma on miinus \(ilm.weatherDict[ilm.tempMin_day*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_day*(-1)]) kraadi"
            case 0:
                self.Day_Text.text = "Külma on miinus \(ilm.weatherDict[ilm.tempMin_day*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
            case 1...100:
                switch Int(ilm.tempMin_day) {
                case -100...0:
                    self.Day_Text.text = "Külma on miinus \(ilm.weatherDict[abs(ilm.tempMin_day)]) kuni pluss \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
                case 0...100:
                    self.Day_Text.text = "Sooja on \(ilm.weatherDict[abs(ilm.tempMin_day)]) kuni \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
                default:
                    print("Ilm")
                }
            default:
                print("Ilm")
                
            }
            
            switch Int(ilm.tempMax_night) {
            case -100 ... -1:
                self.Night_Text.text = "Külma on miinus \(ilm.weatherDict[ilm.tempMin_night*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_night*(-1)]) kraadi"
            case 0:
                self.Night_Text.text = "Külma on miinus \(ilm.weatherDict[ilm.tempMin_night*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
            case 1...100:
                switch Int(ilm.tempMin_night) {
                case -100...0:
                    self.Night_Text.text = "Külma on miinus \(ilm.weatherDict[abs(ilm.tempMin_night)]) kuni pluss \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
                case 0...100:
                    self.Night_Text.text = "Sooja on \(ilm.weatherDict[ilm.tempMin_night]) kuni \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
                default:
                    print("Ilm")
                }
            default:
                print("Ilm")
                
            }
            
            self.Description_Day.text = "Päev. \(ilm.ilmTekst_day)"
            self.Description_Night.text = "Öö. \(ilm.ilmTekst_night)"
            
            
            
        }
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
         // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var Day_Temp: UILabel!
    @IBOutlet weak var Night_Temp: UILabel!
    @IBOutlet weak var Day_Text: UILabel!
    @IBOutlet weak var Night_Text: UILabel!
    @IBOutlet weak var Description_Day: UILabel!
    @IBOutlet weak var Description_Night: UILabel!
    @IBOutlet weak var Wind_Range: UILabel!


}

