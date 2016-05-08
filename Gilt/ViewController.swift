import Cocoa
import GiltKit
import AlamofireImage

class ViewController: NSViewController {

    private let client = Client()

    private var sales = [Sale]() {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var photoView: NSImageView!
    @IBOutlet weak var descriptionLabel: NSTextField!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var tableView: NSTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        client.listSalesForStore(.Men, kind: .Upcoming) { sales in
            dispatch_async(dispatch_get_main_queue()) {
                self.sales = sales
            }
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}


extension ViewController: NSTableViewDataSource, NSTableViewDelegate {

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sales.count
    }

    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeViewWithIdentifier("SaleCell", owner: self) as? SaleCellView else { return NSView() }
        let sale = sales[row]
        cell.photoView.af_setImageWithURL(sale.imageURL)
        cell.nameLabel.stringValue = sale.name
        return cell
    }

    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let sale = sales[row]
        photoView.af_setImageWithURL(sale.imageURL)
        nameLabel.stringValue = sale.name
        descriptionLabel.stringValue = sale.description
        return true
    }
}
