//
//  DetailInterfaceController.swift
//  ArlandaRC
//
//  Created by Fabian Östlund on 09/12/15.
//  Copyright © 2015 Arlanda RC. All rights reserved.
//

import WatchKit
import Foundation


class PostsInterfaceController: WKInterfaceController {
    
    @IBOutlet var postsTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        let topic = context as! Topic
        setTitle(topic.title)
        postsTable.setNumberOfRows(topic.posts.count, withRowType: "PostsRow")
        for (index, post) in topic.posts.enumerate() {
            if let row = self.postsTable.rowControllerAtIndex(index) as? PostsRowController {
                row.postAuthor.setText(post.author)
                row.postMessage.setText(post.message)
                row.postDate.setText(post.date)
            }
        }
        let indexSet = NSMutableIndexSet()
        indexSet.addIndex(0)
        indexSet.addIndex(3)
        postsTable.insertRowsAtIndexes(indexSet, withRowType: "PostsDate")
        if let row = self.postsTable.rowControllerAtIndex(0) as? PostsDateController {
            row.postDate.setText("15-09-12 11:05")
        }
        
        if let row = self.postsTable.rowControllerAtIndex(3) as? PostsDateController {
            row.postDate.setText("15-09-15 11:05")
        }

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.postsTable.scrollToRowAtIndex(topic.posts.count + 1)
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
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName("Author", context: rowIndex)
    }
    
}
