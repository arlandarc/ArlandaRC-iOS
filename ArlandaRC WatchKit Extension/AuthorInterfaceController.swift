//
//  AuthorInterfaceController.swift
//  ArlandaRC
//
//  Created by Fabian Östlund on 09/12/15.
//  Copyright © 2015 Arlanda RC. All rights reserved.
//

import WatchKit
import Foundation

class AuthorInterfaceController: WKInterfaceController {

    @IBOutlet var avatar: WKInterfaceImage!
    @IBOutlet var name: WKInterfaceLabel!
    @IBOutlet var signature: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        let urlPath: String = "http://www.arlandarc.se/forum/download/file.php?avatar=57_1242235689.gif"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {(data, reponse, error) in
            if error == nil {
                self.avatar.setImage(UIImage(data: data!))
            }
        })
        task.resume()
        
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}