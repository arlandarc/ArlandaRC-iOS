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
        let indexSet = NSMutableIndexSet()
        for (index, post) in topic.posts.enumerate() {
            if let row = self.postsTable.rowControllerAtIndex(index) as? PostsRowController {
                row.postAuthor.setText(post.author)
                row.postMessage.setText(post.message)
            }

            if index == 0 {
                indexSet.addIndex(index)
            } else {
                indexSet.addIndex(index+index)
            }
        }

        postsTable.insertRowsAtIndexes(indexSet, withRowType: "PostsDate")
        for var index = 0; index < postsTable.numberOfRows; ++index {
            if let row = self.postsTable.rowControllerAtIndex(index) as? PostsDateController {
                row.postDate.setText(topic.posts[index / 2].date)
            }
        }

        if topic.posts.count > 1 {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.postsTable.scrollToRowAtIndex(self.postsTable.numberOfRows - 1)
            }
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
