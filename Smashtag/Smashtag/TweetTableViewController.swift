import UIKit
import Alamofire
import ReactiveCocoa
import ReactiveSwift
import Twitter

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    let tweetSignal = MutableProperty<[Array<Twitter.Tweet>]>([])
    let searchSignal = MutableProperty<String>("")
    var viewModel: TweetTableViewModel!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if viewModel == nil {
            viewModel = TweetTableViewModel(searchText: "")
        }
        
        searchSignal <~ viewModel.searchText.producer
        
        let _ = searchSignal.producer.startWithValues { _ in
            self.searchTextField?.resignFirstResponder()
            self.viewModel.removeAllTweets()
            self.tableView.reloadData()
            self.searchForTweets()
            self.title = self.viewModel.getSearchText()
        }
        
        if viewModel.getSearchText() != "" {
            self.searchTextField?.text = viewModel.getSearchText()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MentionsSegue" {
            if let destinationViewController = segue.destination as? MentionsTableViewController {
                let cell = sender as? TweetTableViewCell
                destinationViewController.viewModel = MentionsTableViewModel(tweet: (cell?.tweet)!)
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            viewModel.setSearchText(searchTextField.text!)
        }
        return true
    }
    
    // MARK: - Private Methods
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func twitterRequest() -> Twitter.Request? {
        if !viewModel.getSearchText().isEmpty {
            return Twitter.Request(search: viewModel.getSearchText(), count: 100)
        }
        return nil
    }
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchTweets({ [weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.viewModel.insertNewTweets(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            })
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfTweets
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTweetAt(index: section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)
        
        let tweet = viewModel.getTweetAt(index: indexPath.section)[indexPath.row]
        
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        
        return cell
    }

}
