actor DatabaseActor {
  private var implementation: DatabaseImplementation

  init(implementation: DatabaseImplementation) {
    self.implementation = implementation
  }

  func migrate() {
    self.implementation = DatabaseImplementation.live
  }

  func persist(_ model: SomeModel) async throws {
    try await implementation.persist(model)
  }

  func retrieve() async throws -> [SomeModel] {
    try await implementation.retrieve()
  }
}
