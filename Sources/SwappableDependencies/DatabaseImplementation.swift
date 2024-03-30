import GRDB

struct DatabaseImplementation {
  var persist: @Sendable (Person) async throws -> Void
  var retrieve: @Sendable () async throws -> [Person]
}

extension DatabaseMigrator {
	mutating func registerVersion1() {
		self.registerMigration("version1") { db in
			try db.create(table: "person") { t in
				t.autoIncrementedPrimaryKey("id")
				t.column("name", .text)
					.notNull()
			}
		}
	}
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

	static func live(_ writer: any DatabaseWriter) -> Self {
		Self(
			persist: { model in
				try await writer.write { db in
					try model.save(db)
				}
			},
			retrieve: {
				try await writer.read { db in
					try Person.fetchAll(db)
				}
			}
		)
	}
}
