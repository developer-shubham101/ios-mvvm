
import Foundation

enum UserValidationState {
  case valid
  case invalid(String)
}

class UserViewModel {
  fileprivate let minUsernameLength = 4
  fileprivate let minPasswordLength = 5
  fileprivate let codeRefreshTime = 5.0

  fileprivate var user = User()

  var username: String {
    return user.username
  }

  var password: String {
    return user.password
  }

  var protectedUsername: String {
    let characters = username

    if characters.count >= minUsernameLength {
      var displayName = [Character]()
      for (index, character) in characters.enumerated() {
        if index > characters.count - minUsernameLength {
          displayName.append(character)
        } else {
          displayName.append("*")
        }
      }
      return String(displayName)
    }

    return username
  }

  var accessCode: Box<String?> = Box(nil)

  init(user: User = User()) {
    self.user = user
    startAccessCodeTimer()
  }
}

// MARK: Public Methods
extension UserViewModel {
  func updateUsername(_ username: String) {
    user.username = username
  }

  func updatePassword(_ password: String) {
    user.password = password
  }

  func validate() -> UserValidationState {
    if user.username.isEmpty || user.password.isEmpty {
      return .invalid("Username and password are required.")
    }

    if user.username.count < minUsernameLength {
      return .invalid("Username needs to be at least \(minUsernameLength) characters long.")
    }

    if user.password.count < minPasswordLength {
      return .invalid("Password needs to be at least \(minPasswordLength) characters long.")
    }

    return .valid
  }

  func login(_ completion: @escaping (_ errorString: String?) -> Void) {
    LoginService.loginWithUsername(user.username, password: user.password) { success in
      if success {
        completion(nil)
      } else {
        completion("Invalid credentials.")
      }
    }
  }
}

// MARK: - Private Methods
private extension UserViewModel {
  func startAccessCodeTimer() {
    accessCode.value = LoginService.generateAccessCode()

    dispatchAfter(codeRefreshTime) { [weak self] in
      self?.startAccessCodeTimer()
    }
  }
}
