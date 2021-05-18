//
//  WebsocketClient.swift
//  websocket-demo
//
//  Created by Daniel No on 4/29/21.
//

import Foundation


public class WebsocketClient : NSObject,URLSessionWebSocketDelegate{
//    let sandboxapiKey = "sandbox_c25fi52ad3iafjnnjgjg"
    let apiKey = "c25fi52ad3iafjnnjgj0"
    
    var session : URLSession!
    var queue = OperationQueue()
    var websocketTask : URLSessionWebSocketTask!
    
    public override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: queue)
    }
    
    public func connect(){
       websocketTask = session.webSocketTask(with: URL(string: "wss://ws.finnhub.io?token=\(apiKey)")!)
        websocketTask.resume()
        
        let msg = "{\"type\":\"subscribe\",\"symbol\":\"AAPL\"}"
        
        let message = URLSessionWebSocketTask.Message.string(msg)
        websocketTask.send(message) { (err) in
            print(err)
        }
        listen()
        
    }
    
    public func listen(){
        websocketTask.receive { result in
              switch result {
              case .failure(let error):
                print("Error in receiving message: \(error)")
              case .success(let message):
                switch message {
                case .string(let text):
                  print("Received string: \(text)")
                case .data(let data):
                  print("Received data: \(data)")
                }
              }
            }
            listen()
        
    }

    
        
}

extension WebsocketClient{
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("did open protocol")
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("did close")
    }
    
}
