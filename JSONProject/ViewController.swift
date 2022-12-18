//
//  ViewController.swift
//  JSONProject
//
//  Created by Lepestok Jora on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jsonLabel: UILabel!
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
            startJson()
        case .clean:
            self.jsonLabel.text = "Press start button"
            statusBtn = .start
            startButton.setTitle("Start", for: .normal)
        }

        weitActivityIndicator.isHidden = false
        startButton.isUserInteractionEnabled = false
    }
    
    
    
    
    //3. Написать функцию запроса данных с сервера
    private func startJson() {
        guard let url = URL(string: urlJson) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            //если есть у меня данные и ответ а иначе вывожу ошибку и выхлжу
            guard let data = data else {
                print("No data received:", error ?? URLError(.badServerResponse))
                self.startButton.isUserInteractionEnabled = true
                return
            }
            // есть ответ в дате значить парссим
            let decoder = JSONDecoder()
            //5. Распарсить JSON,
            do {
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                //6. Отобразить данные на консоли.(вызвать фукцию принт из своей модели)
                DispatchQueue.main.async {
                    self.showResult(jsonData)
                }
            }
            catch let parseError {
                self.startButton.isUserInteractionEnabled = true
                print("Parsing error:", parseError, String(describing: String(data: data, encoding: .utf8)))
            }
            
        }.resume()
        
        
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
        
        self.jsonLabel.text = resultStr
        weitActivityIndicator.isHidden = true
        startButton.setTitle("Clean", for: .normal)
        statusBtn = .clean
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: {
            self.startButton.isUserInteractionEnabled = true
        })
    }
    
}

