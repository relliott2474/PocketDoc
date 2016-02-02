//
//  PFViewController.swift
//  ParseDownload
//
//  Created by HotRod on 7/3/15.
//  Copyright (c) 2015 Rod. All rights reserved.
//

import UIKit
import Parse
import Bolts

class PFViewController: UIViewController, UIWebViewDelegate {
    var currentObject = PFObject?()
    
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pdfWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = currentObject{
            
            let pdfOutput:PFFile! = object.objectForKey("pdfName") as! PFFile!
            if let currentPDF = pdfOutput{
                if currentPDF.url != nil{
                    let urlFromParse = NSURL(string: currentPDF.url!)
                    let request = NSURLRequest(URL:urlFromParse!)
                    self.pdfWebView.loadRequest(request)
                   
                }
                
                let outPut = object.objectForKey("artNames") as! NSString
                //println("the appropriate response is \(outPut)")
                let object:AnyObject = outPut
                navigationItem.title = object as? String
                
            }
            
        }
    }
    
     func webViewDidStartLoad(webView: UIWebView){
        loadIndicator.hidden = false
        loadIndicator.startAnimating()
        print("Webview started Loading", terminator: "")
    }
     func webViewDidFinishLoad(webView: UIWebView){
        loadIndicator.hidden = true
        loadIndicator.stopAnimating()
        print("Webview stopped Loading", terminator: "")

    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
