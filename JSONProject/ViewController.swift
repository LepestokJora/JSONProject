//
//  ViewController.swift
//  JSONProject
//
//  Created by Lepestok Jora on 13.12.2022.
//

import UIKit

//1. Выберите любой публичный API на свой вкус
//2. данные которого вы должны будете в последующем отобразить в своем приложении.
//3. Написать функцию запроса данных с сервера
//4. В текущем ДЗ необходимо создать модель для парсинга джейсона
//5. Распарсить JSON,
//6. Отобразить данные на консоли.(вызвать фукцию принт из своей модели)



class ViewController: UIViewController {

    @IBOutlet weak var jsonLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    let urlJson: String = "https://go-apod.herokuapp.com/apod"
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    private func startJson() {
        
        guard let url = URL(string: urlJson) else { return }
      
        URLSession.shared.dataTask(with: url) { data, response, error in
            //
            guard let data, let response else {
                print(error?.localizedDescription ?? "No error discription")
                return
            }
            
            print(response)
        }
        
    }
    
    
    
}

