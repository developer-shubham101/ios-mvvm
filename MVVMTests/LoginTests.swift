import XCTest
@testable import MVVM

class LoginTests: XCTestCase {

  var validUserViewModel: UserViewModel!
  var invalidUserViewModel: UserViewModel!

  override func setUp() {
    super.setUp()

    let user = User(username: "ecerney", password: "swift")
    validUserViewModel = UserViewModel(user: user)

    invalidUserViewModel = UserViewModel()
  }

  override func tearDown() {

    super.tearDown()
  }

  func testUsername() {
    XCTAssertEqual(validUserViewModel.username, "ecerney")
  }

  func testPassword() {
    XCTAssertEqual(validUserViewModel.password, "swift")
  }

  func testProtectedUsernameLong() {
    XCTAssertEqual(validUserViewModel.protectedUsername, "****ney")
  }

  func testProtectedUsernameShort() {
    validUserViewModel = UserViewModel(user: User(username: "ec", password: "swift"))
    XCTAssertEqual(validUserViewModel.protectedUsername, "ec")
  }

  func testUpdateUsername() {
    validUserViewModel.updateUsername("rwenderlich")
    XCTAssertEqual(validUserViewModel.username, "rwenderlich")
  }

  func testUpdatePassword() {
    validUserViewModel.updatePassword("vicki")
    XCTAssertEqual(validUserViewModel.password, "vicki")
  }

  func testValidateNoUserOrPassword() {
    let validation = invalidUserViewModel.validate()

    if case .invalid(let message) = validation {
      XCTAssertEqual(message, "Username and password are required.")
    } else {
      XCTAssert(false)
    }
  }

  func testValidateNoPassword() {
    invalidUserViewModel = UserViewModel(user: User(username: "ecerney", password: ""))
    let validation = invalidUserViewModel.validate()

    if case .invalid(let message) = validation {
      XCTAssertEqual(message, "Username and password are required.")
    } else {
      XCTAssert(false)
    }
  }

  func testValidateShortUsername() {
    invalidUserViewModel = UserViewModel(user: User(username: "ec", password: "swift"))
    let validation = invalidUserViewModel.validate()

    if case .invalid(let message) = validation {
      XCTAssertEqual(message, "Username needs to be at least 4 characters long.")
    } else {
      XCTAssert(false)
    }
  }

  func testValidateShortPassword() {
    invalidUserViewModel = UserViewModel(user: User(username: "ecerney", password: "sw"))
    let validation = invalidUserViewModel.validate()

    if case .invalid(let message) = validation {
      XCTAssertEqual(message, "Password needs to be at least 5 characters long.")
    } else {
      XCTAssert(false)
    }
  }

  func testValidateValidUser() {
    let validation = validUserViewModel.validate()

    if case .valid = validation {
      XCTAssert(true)
    } else {
      XCTAssert(false)
    }
  }

  func testLoginSuccess() {
    validUserViewModel.login { errorString in
      XCTAssert(errorString == nil)
    }
  }

  func testLoginFailure() {
    invalidUserViewModel.login { errorString in
      XCTAssertEqual(errorString, "Invalid credentials.")
    }
  }
}
