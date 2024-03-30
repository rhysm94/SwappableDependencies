import GRDB

actor DatabaseActor {
	private var implementation: DatabaseImplementation
	
	init(implementation: DatabaseImplementation) {
		self.implementation = implementation
	}
	
	func migrate() throws {
		let queue = try DatabaseQueue()
		
		var migrator = DatabaseMigrator()
		migrator.registerVersion1()
		try migrator.migrate(queue)
		
		self.implementation = DatabaseImplementation.live(queue)
	}
	
	func persist(_ model: Person) async throws {
		try await implementation.persist(model)
	}
	
	func retrieve() async throws -> [Person] {
		try await implementation.retrieve()
	}
}
