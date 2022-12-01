import Foundation

final actor Barrier {
    
    private var task: Task<Void, Error>?
    
    func sleep(seconds: Double) async throws {
        task = Task { [weak self] in
            try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            await self?.removeTask()
        }
        try await wait()
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
