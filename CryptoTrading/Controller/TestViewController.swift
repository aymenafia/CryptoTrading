//
//  TestViewController.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 25/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON
class TestViewController: UIViewController {

    
    let manager = SocketManager(socketURL: URL(string: "https://coincap.io")!, config: [.log(true), .compress])
   
    
    
    
   // var socket = SocketIOClient(manager: SocketManager(socketURL: URL(string: "https://coincap.io")!, config: [.log(true)]), nsp: ("/auction"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let socket = manager.defaultSocket
        
    
        socket.on(clientEvent: .connect) {data, ack in
           // print("socket connected")
        }
        
            socket.on("trades") {data, ack in
            let cur = data[0] as! [String:AnyObject]
            let json = JSON(data)
            //   print(json)
            
            if let resData = json.arrayObject {
                print("xxxxxxxxxx")
                
              //  print((resData as? [[String:AnyObject]])!)
                
                for crypto in (resData as? [[String:AnyObject]])! {
                    print("longlong")
                   print(crypto["msg"]!.value(forKey: "long"))
                 
                    // cell.priceLabel.text = crypto.priceUSD
                    
                    
                }
                
                
            }
            
            socket.connect()
            
            
            /*
             {
             cap24hrChange = "0.14";
             long = Ripple;
             mktcap = "29713829612.81803";
             perc = "0.14";
             price = "0.97132";
             shapeshift = 1;
             short = XRP;
             supply = 38739144847;
             usdVolume = 454756000;
             volume = 454756000;
             vwapData = "0.9683923867120544";
             vwapDataBTC = "0.9683923867120544";
             }

             
             
             
             
             
             
             */
            
            
            
           // socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
             //   socket.emit("update", ["amount": cur + 2.50])
            }
            
          //  ack.with("Got your currentAmount", "dude")
        

        
        
        // Do any additional setup after loading the view.
    }


}
