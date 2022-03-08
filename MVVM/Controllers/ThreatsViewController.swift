import UIKit

class ThreatsViewController: UIViewController {
  fileprivate let cellIdentifier = "ImageCell"
  fileprivate let headerIdentifier = "HeaderView"

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  // TODO: Add ViewModel Property

  override func viewDidLoad() {
    super.viewDidLoad()

    // TODO: Set ViewModel Delegate
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if !LoginService.isAuthenticated {
      presentLoginViewController()
    }
  }
}

// MARK: UICollectionViewDataSource
extension ThreatsViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0 // TODO: Get Number from ViewModel
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0 // TODO: Get Number from ViewModel
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell

    // TODO: Customize Cell Image from ViewModel

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
        as! ResultsHeaderView

      // TODO: Set Title Text from ViewModel

      return headerView
    }

    assert(false, "Unexpected element kind")
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ThreatsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.bounds.width - CGFloat(30)) / 2.0
    return CGSize(width: cellWidth, height: cellWidth)
  }
}

// MARK: Actions
extension ThreatsViewController {
  @IBAction func logoutPressed() {
    LoginService.logout {
      self.presentLoginViewController() {
        // TODO: Clear data in ViewModel
      }
    }
  }
}

// MARK: Private Methods
private extension ThreatsViewController {
  func presentLoginViewController(_ completion: (() -> Void)? = nil) {
    let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    loginVC.loginSuccess = {
      self.activityIndicator.startAnimating()
      self.dismiss(animated: true) {
        // TODO: Load data from ViewModel
      }
    }

    present(loginVC, animated: true, completion: completion)
  }
}

// TODO: Implement ViewModel Delegate
