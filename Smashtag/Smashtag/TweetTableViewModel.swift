import Foundation
import ReactiveCocoa
import ReactiveSwift
import Twitter

class TweetTableViewModel {
    var tweets = [Array<Twitter.Tweet>]()
    
    init() {
        
    }
    
    var numberOfTweets: Int {
        return tweets.count
    }
    
    func getTweetAt(index: Int) -> [Twitter.Tweet] {
        return tweets[index]
    }
}
