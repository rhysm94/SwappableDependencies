import GRDB

struct Person: Hashable, Codable {
	let id: Int64
	let name: String
}

extension Person: FetchableRecord, PersistableRecord {}
