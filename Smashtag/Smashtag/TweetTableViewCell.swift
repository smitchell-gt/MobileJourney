import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        tweetUserLabel?.text = tweet?.user.description
        
        if let tweetText = tweet?.text {
            let highlightedString = NSMutableAttributedString(string: tweetText)
            for mention in (tweet?.userMentions)! {
                if tweetText.contains(mention.keyword) {
                    highlightedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.magenta, range: mention.nsrange)
                }
            }
            
            for mention in (tweet?.hashtags)! {
                if tweetText.contains(mention.keyword) {
                    highlightedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: mention.nsrange)
                }
            }
            
            for mention in (tweet?.urls)! {
                if tweetText.contains(mention.keyword) {
                    highlightedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: mention.nsrange)
                }
            }
            
            tweetTextLabel?.attributedText = highlightedString
        }
        
        if let profileImageURL = tweet?.user.profileImageURL {
            // TODO: blocks main thread
            if let imageData = try? Data(contentsOf: profileImageURL) {
                tweetProfileImageView?.image = UIImage(data: imageData)
            }
        } else {
            tweetProfileImageView?.image = nil
        }
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        } else {
            tweetCreatedLabel?.text = nil
        }
    }
}
