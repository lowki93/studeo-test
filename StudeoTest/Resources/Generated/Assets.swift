// swiftlint:disable all
import SwiftUI

enum Assets: String {
  case logo = "Logo"
}

extension Image {
  init(_ asset: Assets) {
    self.init(asset.rawValue)
  }
}

extension UIImage {
  convenience init?(_ asset: Assets) {
    self.init(named: asset.rawValue)
  }
}
