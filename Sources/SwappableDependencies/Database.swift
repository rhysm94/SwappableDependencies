struct SomeModel {}

struct Database {
  var migrate: @Sendable () async -> Void
  var persist: @Sendable (SomeModel) async throws -> Void
  var retrieve: @Sendable () async throws -> [SomeModel]
}

extension Database {
  static var liveValue: Self {
    let actor = DatabaseActor(implementation: .failing)

    return Self(
      migrate: { await actor.migrate() },
      persist: { model in
        try await actor.persist(model)
      },
      retrieve: {
        try await actor.retrieve()
      }
    )
  }
}
