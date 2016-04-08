//
//  RESTModule.swift
//  Jared
//
//  Created by Jared Derulo on 4/5/16.
//  Copyright © 2016 Zeke Snider. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var twitterInstance: Twitter = Twitter()

struct RESTModule: RoutingModule {
    var routes: [Route] = []
    
    init() {
        let youtube = Route(comparison: .Contains, string:"https://www.youtube.com", call: self.youtubeCall)
        let twitter = Route(comparison: .Contains, string: "twitter.com", call: self.twitterCall)
        routes = [youtube, twitter]
        
        let twitterInstance = Twitter()
    }
    
    func youtubeCall(message:String, myRoom: Room) -> Void {
        do {
            let regex = try NSRegularExpression(pattern: "v=(.+?)(?=$|&)", options: NSRegularExpressionOptions.CaseInsensitive)
            let match: NSTextCheckingResult? = regex.firstMatchInString(message, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, message.characters.count))
            print(match)
            let videoID = (message as NSString).substringWithRange(match!.range).stringByReplacingOccurrencesOfString("v=", withString: "")
            print(videoID)
            
            Alamofire.request(.GET, "https://gdata.youtube.com/feeds/api/videos/\(videoID)?v=2").responseJSON { response in
                
            }
            
        } catch _ {
            print("error")
        }
    }
    func twitterCall(message:String, myRoom: Room) -> Void {
        let mystring = "narcissawright"
        twitterInstance.getTimelineForScreenName("narcissawright")
    }
}


