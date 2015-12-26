//
//  InterfaceController.swift
//  ArlandaRC WatchKit Extension
//
//  Created by Fabian Östlund on 09/12/15.
//  Copyright © 2015 Arlanda RC. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var topicsTable: WKInterfaceTable!

    @IBAction func onMenuReload() {
        self.animateWithDuration(0.2) {
            self.topicsTable.setAlpha(0)
        }
        loadTableData()
    }
    
    var topics = [Topic]()
    
    override init() {
        super.init()
        topicsTable.setAlpha(0)
        loadTableData()
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
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
        if let row = topicsTable.rowControllerAtIndex(rowIndex) as? TopicsRowController {
            row.rowIsUnread.setHidden(true)
        }
        pushControllerWithName("Posts", context: topics[rowIndex])
    }
    
    
    func loadTableData() {
        print("Loading new")
        let urlPath: String = "http://api.arlandarc.se/1.0/activetopics"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {(data, reponse, error) in
            if error == nil {
              let json = JSON(data: data!)
              if let topicsResponse = json[].array {
                  self.topicsTable.setNumberOfRows(topicsResponse.count, withRowType: "TopicsRow")
                  for (index, topic) in topicsResponse.enumerate() {
                      if let row = self.topicsTable.rowControllerAtIndex(index) as? TopicsRowController {
                          row.rowTitle.setText(topic["title"].string)
                          row.rowCategory.setText(topic["category"].string)

                          let date = NSDate(timeIntervalSince1970: topic["last_post_time"].doubleValue)
                          let formatter = NSDateFormatter()
                          formatter.dateFormat = "YY-MM-d HH:mm"
                          var dateExtension = ""
                          if (NSCalendar.currentCalendar().isDateInToday(date)) {
                              dateExtension = "Idag"
                              formatter.dateFormat = "HH:mm"
                          } else if (NSCalendar.currentCalendar().isDateInYesterday(date)) {
                              dateExtension = "Igår"
                              formatter.dateFormat = "HH:mm"
                          } else {
                              formatter.dateFormat = "YYYY-MM-dd"
                          }
                          formatter.stringFromDate(date)
                          row.rowDate.setText((!dateExtension.isEmpty ? dateExtension + " " : "") + formatter.stringFromDate(date))

                          var posts = [Post]()
                          for (index, post) in (topic["posts"].array?.enumerate())! {
                              posts.append(Post(postAuthor: "Ove", postMessage: post.string!, postDate: "11:05"))
                          }
                          self.topics.append(Topic(topicTitle: topic["title"].string!,
                              topicCategory: topic["category"].string!,
                              topicPosts: posts))
                        
                        
                      }
                  }
              } else {
                  print("No array")
              }
            } else {
              print("Something went wrong")
            }
            //self.activityIndicatorCar.setHidden(true)
            self.animateWithDuration(0.3) {
                self.topicsTable.setAlpha(1)
            }
            self.topicsTable.scrollToRowAtIndex(0)
            
        })
        task.resume()
    }
    
}