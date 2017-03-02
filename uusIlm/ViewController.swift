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
var kuupaev = 0



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherData()
        Date_1_Button.layer.backgroundColor = UIColor.lightGray.cgColor
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
    @IBOutlet weak var Date_1_Button: UIButton!
    @IBOutlet weak var Date_2_Button: UIButton!
    @IBOutlet weak var Date_3_Button: UIButton!
    @IBOutlet weak var Date_4_Button: UIButton!
    
    @IBAction func Nupuvajutus(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            kuupaev = 0
            reset_bg_color()
            //button?.layer.borderColor = UIColor.lightGray.cgColor
            Date_1_Button.layer.backgroundColor = UIColor.lightGray.cgColor
        case 1:
            kuupaev = 1
            reset_bg_color()
            Date_2_Button.layer.backgroundColor = UIColor.lightGray.cgColor
        case 2:
            kuupaev = 2
            reset_bg_color()
            Date_3_Button.layer.backgroundColor = UIColor.lightGray.cgColor
        case 3:
            kuupaev = 3
            reset_bg_color()
            Date_4_Button.layer.backgroundColor = UIColor.lightGray.cgColor
        default:
            return
        }
        weatherData()
    }
    
    func reset_bg_color() {
        for button_bg in [Date_1_Button, Date_2_Button, Date_3_Button, Date_4_Button] {
            button_bg?.layer.backgroundColor = nil
        }
    }
    
    func weatherData() {
        
        Alamofire.request("https://www.ilmateenistus.ee/ilma_andmed/xml/forecast.php").responseString { response in
            let xmltest = SWXMLHash.parse(response.data!)
            
            ilm.tempMin_day = Int(xmltest["forecasts"]["forecast"][kuupaev]["day"]["tempmin"].element!.text!)!
            ilm.tempMax_day = Int(xmltest["forecasts"]["forecast"][kuupaev]["day"]["tempmax"].element!.text!)!
            ilm.ilmTekst_day = xmltest["forecasts"]["forecast"][kuupaev]["day"]["text"].element!.text!
            
            ilm.tempMin_night = Int(xmltest["forecasts"]["forecast"][kuupaev]["night"]["tempmin"].element!.text!)!
            ilm.tempMax_night = Int(xmltest["forecasts"]["forecast"][kuupaev]["night"]["tempmax"].element!.text!)!
            ilm.ilmTekst_night = xmltest["forecasts"]["forecast"][kuupaev]["night"]["text"].element!.text!
            
            for i in 0...3 {
                ilm.weather_date.append(xmltest["forecasts"]["forecast"][i].element!.attribute(by: "date")!.text)
            }
            
            self.Date_1_Button.setTitle(ilm.weather_date[0], for: .normal)
            self.Date_2_Button.setTitle(ilm.weather_date[1], for: .normal)
            self.Date_3_Button.setTitle(ilm.weather_date[2], for: .normal)
            self.Date_4_Button.setTitle(ilm.weather_date[3], for: .normal)
            
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_min.append(Int( elem["speedmin"].element!.text! )!) }
            for elem in xmltest["forecasts"]["forecast"][0]["day"]["wind"] {ilm.rida_max.append(Int(elem["speedmax"].element!.text! )!) }
            
            self.Wind_Range.text = "Tuule kiirus tänasel päeval on \(ilm.rida_min.max()!) kuni \(ilm.rida_max.max()!) m/s"
            
            self.Day_Temp.text = "Päev \(ilm.tempMin_day) to \(ilm.tempMax_day) °C"
            self.Night_Temp.text = "Öö \(ilm.tempMin_night) to \(ilm.tempMax_night) °C"
            
            switch Int(ilm.tempMax_day) {
            case -100 ... -1:
                self.Day_Text.text = "Päeval on külma miinus \(ilm.weatherDict[ilm.tempMin_day*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_day*(-1)]) kraadi"
            case 0:
                self.Day_Text.text = "Päeval on külma miinus \(ilm.weatherDict[ilm.tempMin_day*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
            case 1...100:
                switch Int(ilm.tempMin_day) {
                case -100...0:
                    self.Day_Text.text = "Päeval on külma miinus \(ilm.weatherDict[abs(ilm.tempMin_day)]) kuni pluss \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
                case 0...100:
                    self.Day_Text.text = "Päeval on sooja \(ilm.weatherDict[abs(ilm.tempMin_day)]) kuni \(ilm.weatherDict[ilm.tempMax_day]) kraadi"
                default:
                    return
                }
            default:
                return
            }
            
            switch Int(ilm.tempMax_night) {
            case -100 ... -1:
                self.Night_Text.text = "Öösel on külma miinus \(ilm.weatherDict[ilm.tempMin_night*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_night*(-1)]) kraadi"
            case 0:
                self.Night_Text.text = "Öösel on külma miinus \(ilm.weatherDict[ilm.tempMin_night*(-1)]) kuni \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
            case 1...100:
                switch Int(ilm.tempMin_night) {
                case -100...0:
                    self.Night_Text.text = "Öösel on külma miinus \(ilm.weatherDict[abs(ilm.tempMin_night)]) kuni pluss \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
                case 0...100:
                    self.Night_Text.text = "Öösel on sooja \(ilm.weatherDict[ilm.tempMin_night]) kuni \(ilm.weatherDict[ilm.tempMax_night]) kraadi"
                default:
                    return
                }
            default:
                return
            }
            
            self.Description_Day.text = "Päev. \(ilm.ilmTekst_day)"
            self.Description_Night.text = "Öö. \(ilm.ilmTekst_night)"
    }
        
        for button in [Date_1_Button, Date_2_Button, Date_3_Button, Date_4_Button] {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
                   }
        
        for layer in [Day_Temp, Night_Temp, Day_Text, Night_Text, Description_Day, Description_Night, Wind_Range] {
            layer?.layer.borderWidth = 1
            
        }
        
        
    }
   


}

