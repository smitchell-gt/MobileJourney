import Foundation
import ReactiveCocoa
import ReactiveSwift
import Twitter

class MentionsTableViewModel {
    var tweet: MutableProperty<Twitter.Tweet>
    
    init(tweet: Twitter.Tweet) {
        self.tweet = MutableProperty(tweet)
    }
    
    func getAuthorName() -> String {
        return tweet.value.user.name
    }
    
    func getImages() -> [Twitter.MediaItem] {
        return tweet.value.media 
    }
    
    func getUserMentions() -> [Twitter.Mention] {
        return tweet.value.userMentions
    }
    
    func getHashtagMentions() -> [Twitter.Mention] {
        return tweet.value.hashtags
    }
    
    func getUrlMentions() -> [Twitter.Mention] {
        return tweet.value.urls
    }
    
}
