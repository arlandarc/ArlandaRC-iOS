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

    @IBOutlet var avatarGroup: WKInterfaceGroup!
    @IBOutlet var avatar: WKInterfaceImage!
    @IBOutlet var name: WKInterfaceLabel!
    @IBOutlet var signature: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        let avatarUrl = "http://www.arlandarc.se/forum/download/file.php?avatar=56_1273278893.jpg"
        if (avatarUrl.isEmpty) {
          avatarGroup.setHidden(true)
        } else {
            let urlPath: String = avatarUrl
            let url = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {(data, response, error) in
                if error == nil {
                    self.avatar.setImage(UIImage(data: data!))
                    self.animateWithDuration(0.2) {
                        self.avatar.setAlpha(1)
                    }
                }
            })
            task.resume()
        }
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