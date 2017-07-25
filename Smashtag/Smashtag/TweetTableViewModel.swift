import Foundation
import ReactiveCocoa
import ReactiveSwift
import Twitter

class TweetTableViewModel {
    var tweets: MutableProperty<[Array<Twitter.Tweet>]>
    var searchText: MutableProperty<String>
    
    init() {
        tweets = MutableProperty<[Array<Twitter.Tweet>]>([])
        searchText = MutableProperty<String>("")
    }
    
    // MARK: - Tweets
    
    var numberOfTweets: Int {
        return tweets.value.count
    }
    
    func getTweetAt(index: Int) -> [Twitter.Tweet] {
        return tweets.value[index]
    }
    
    func insertNewTweets(_ newTweets: [Twitter.Tweet], at: Int) {
        tweets.value.insert(newTweets, at: at)
    }
    
    func removeAllTweets() {
        tweets.value.removeAll()
    }
    
    // MARK: - SearchText
    
    func getSearchText() -> String {
        return searchText.value
    }
    
    func setSearchText(_ text: String) {
        searchText.value = text
    }
}
