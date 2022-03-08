
import Foundation

struct SpyService {
  static func getNearbyThreats(_ completion: @escaping ([Threat]) -> ()) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      sleep(1)
      let bundlePath = Bundle.main.bundlePath + "/ThreatData"
      let enumerator = FileManager.default.enumerator(atPath: bundlePath)

      var threats = [Threat]()

      while let element = enumerator?.nextObject() as? String {
        var isDir: ObjCBool = false
        let path = bundlePath + "/\(element)"
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
          if isDir.boolValue {
            let contents = try! FileManager.default.contentsOfDirectory(atPath: path)

            var imagePaths = [String]()
            for image in contents {
              let fullPath = path + "/\(image)"
              imagePaths.append(fullPath)
            }
            let nameComponents = element.components(separatedBy: " ")

            let threat = Threat(firstName: nameComponents[0], lastName: nameComponents[1], imagePaths: imagePaths)
            threats.append(threat)
          }
        }
      }

      DispatchQueue.main.async {
        completion(threats)
      }
    }
  }
}
