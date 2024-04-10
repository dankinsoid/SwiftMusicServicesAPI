import Foundation

final actor Barrier {

	private var task: Task<Void, Error>?

	func sleep(seconds: Double) async throws {
		task = Task {
			try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
		}
		try await wait()
        task = nil
	}

	func wait() async throws {
		guard let task else {
			return
		}
		try await task.value
	}

	private func removeTask() {
		task = nil
	}
}
