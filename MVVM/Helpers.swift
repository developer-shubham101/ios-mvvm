
import Foundation

func dispatchAfter(_ seconds: Double, block: @escaping () -> Void) {
  let dispatchTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
  DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: block)
}
