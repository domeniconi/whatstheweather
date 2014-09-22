//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Nicolas Domeniconi on 10/09/2014.
//  Copyright (c) 2014 domeniconi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var message: UILabel!
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //Hide Keyboard after user taps the button
        self.view.endEditing(true)
        
        //This URL is for testing purposes please change to a different one for live use
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest"
        
        var url = NSURL(string: urlString)
        
        //Create session using the NSURL we created
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            
            var urlContent = (NSString(data: data , encoding: NSUTF8StringEncoding))
            
            var contentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
            
            //Check if there is anything inside the array after parsing
            if contentArray[1] as NSString != "" {
                
                var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
                
                var content = newContentArray[0] as String
                
                self.message.text = content.stringByReplacingOccurrencesOfString("&deg", withString: "º")
                
            } else {
                
                self.message.text = "Couldn't find that city - Please try again"
            }
           
            


        }
        task.resume()
        
        
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

