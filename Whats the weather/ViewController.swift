//
//  ViewController.swift
//  Whats the weather
//
//  Created by Andrei Momot on 9/27/16.
//  Copyright © 2016 Andrei Momot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func findWeather(_ sender: AnyObject) {
        
        sender.setTitleColor(UIColor.red, for: UIControlState())
        
        var wasSuccessful = false
        
        let attemptedUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let websiteArray = webContent!.components(separatedBy: "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    
                    let weatherArray = websiteArray[1].components(separatedBy: "</span>")
                    
                    if weatherArray.count > 1 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "°")
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.resultLabel.text = weatherSummary
                            self.resultLabel.textColor = UIColor.black
                            
                        })
                        
                    }
                }
            }
            
            if wasSuccessful == false {
            
                self.resultLabel.text = "Incorrect city."
            
            }
            
        }) 
        
        
        task.resume()
        } else {
        
            self.resultLabel.text = "Incorrect city."
            self.resultLabel.textColor = UIColor.red

        
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

