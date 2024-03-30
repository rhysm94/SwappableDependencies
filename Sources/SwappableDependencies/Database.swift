import Dependencies
import DependenciesMacros

@DependencyClient
struct Database {
	var migrate: @Sendable () async throws -> Void
	var persist: @Sendable (Person) async throws -> Void
	var retrieve: @Sendable () async throws -> [Person]
}

extension Database: DependencyKey {
	static let testValue = Self()

	static var liveValue: Self {
		let actor = DatabaseActor(implementation: .failing)

		return Self(
			migrate: { try await actor.migrate() },
			persist: { model in
				try await actor.persist(model)
			},
			retrieve: {
				try await actor.retrieve()
			}
		)
	}
}
