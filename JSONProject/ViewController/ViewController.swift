//
//  ViewController.swift
//  JSONProject
//
//  Created by Lepestok Jora on 13.12.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var jsonTV: UITextView!
    @IBOutlet weak var weitActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var startButton: UIButton!
   
    enum StatusBrn {
        case start, clean
    }
    
    //1. Выберите любой публичный API на свой вкус данные которого вы должны будете в последующем отобразить в своем приложении.
    let urlJson: String = "https://go-apod.herokuapp.com/apod"
    private var statusBtn:StatusBrn = .start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weitActivityIndicator.isHidden = true
        weitActivityIndicator.startAnimating()
        
    }

    @IBAction func startAction() {
        switch statusBtn {
        case .start:
            NetworkManager.shared.startJson { responseData in
                self.showResult(responseData)
            } errorCompletion: { error in
                print ("\(error)")
            }

        case .clean:
            self.jsonTV.text = "Press start button"
            statusBtn = .start
            startButton.setTitle("Start", for: .normal)
        }

        weitActivityIndicator.isHidden = false
        startButton.isUserInteractionEnabled = false
    }
    
    
   
    
    
    
    private func showResult(_ responseData:ResponseData?) {
        var resultStr = ""
        if let url = responseData?.url {
            resultStr.append("url: \(url)\n\n")
        }
        if let title = responseData?.title {
            resultStr.append("title: \(title)\n\n")
        }
        if let service_version = responseData?.service_version {
            resultStr.append("service_version: \(service_version)\n\n")
        }
        if let media_type = responseData?.media_type {
            resultStr.append("media_type: \(media_type)\n\n")
        }
        if let hdurl = responseData?.hdurl {
            resultStr.append("hdurl: \(hdurl)\n\n")
        }
        if let explanation = responseData?.explanation {
            resultStr.append("explanation: \(explanation)\n\n")
        }
        if let date = responseData?.date {
            resultStr.append("date: \(date)\n\n")
        }
        if let copyright = responseData?.copyright {
            resultStr.append("copyright: \(copyright)\n\n")
        }
        
        self.jsonTV.text = resultStr
        weitActivityIndicator.isHidden = true
        startButton.setTitle("Clean", for: .normal)
        statusBtn = .clean
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: {
            self.startButton.isUserInteractionEnabled = true
        })
    }

}
