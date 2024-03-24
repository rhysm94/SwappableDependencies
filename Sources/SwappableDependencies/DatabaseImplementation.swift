struct DatabaseImplementation {
  var persist: @Sendable (SomeModel) async throws -> Void
  var retrieve: @Sendable () async throws -> [SomeModel]
}

extension DatabaseImplementation {
  enum Failure: Error {
    case notMigrated
  }

  static var failing: Self {
    Self(
      persist: { _ in throw Failure.notMigrated },
      retrieve: { throw Failure.notMigrated }
    )
  }

  static var live: Self {
    Self(
      persist: { _ in },
      retrieve: { [] }
    )
  }
}
