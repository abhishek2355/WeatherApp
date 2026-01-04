import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.backgroundColor = ColorConstant.backgroundDarkBlue
    }
    
    func setupUI() {
        // Override in child
    }
    
    func bindViewModel() {
        // Override in child
    }
}
