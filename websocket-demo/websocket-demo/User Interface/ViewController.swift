//
//  ViewController.swift
//  websocket-demo
//
//  Created by Daniel No on 4/29/21.
//

import UIKit

class ViewController: UIViewController {
    let websocketClient  = WebsocketClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startSocket()
    }
    
    func startSocket(){
        websocketClient.connect()
        
        
    }


}

