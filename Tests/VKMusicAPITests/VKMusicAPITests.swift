import Foundation
import SwiftHttp
import VKMusicAPI
import XCTest
import VDCodable

final class VKMusicAPITests: XCTestCase {

    lazy var api = VK.API(
        client: Client(tests: self),
        webCookies: [
            "remixlang": "0",
            "remixstlid": "9110096011347844561_CvfczW9AtXB8g7D1uOaH7jcvpZsKIU7sHwCZjzzmCBw",
            "remixstid": "1308210270_QO3qmRsQyQPFC3AWhQfPJjzH66sIWTlhDGx9jT0L6mD",
            "remixuas": "ZTlkM2JiOTNlYzE5ZDFjZmFlZDM0ZGRl",
            "remixdark_color_scheme": "1",
            "remixcolor_scheme_mode": "auto",
            "tmr_lvid": "8ac84fd28baa7fbd39f00276f29a6d86","tmr_lvidTS": "1702731721194",
            "remixuacck": "62bfa1c57d2ec3a230",
            "remixdt": "0",
            "remixscreen_width": "1512",
            "remixscreen_height": "982",
            "remixscreen_dpr": "2",
            "remixscreen_depth": "30",
            "remixscreen_winzoom": "1",
            "remixrt": "1",
            "remixua": "52%7C627%7C110%7C1359786057",
            "remixrefkey": "ae6abf715b618a4153",
            "remixscreen_orient": "1",
            "remixnp": "0",
            "remixmdevice": "1512/982/2/!!-!!!!!!!!-/1458",
            "remixff": "10111111111111",
            "remixgp": "0c63bbf32e7eba44c75a0f4759a39abb",
            "remixmvk-fp": "7471ee15f923285b3d57c6b50b58dbaf",
            "remixcurr_audio": "undefined",
            "remixsuc": "2%3A",
            "remixdmgr_tmp": "81c43f0bf3c4758b7b0f05673edb656fed2a4ad9e6fadca2014bb683087b4f14",
            "remixdmgr": "3be6c9a8d7dac7f6aa1d8b5c77d316112ae3a9c1822078bf132dc3ca98257269",
            "remixmdv": "XwLjdDWraX1kUo78",
            "remixaudio_show_alert_today": "0",
            "tmr_detect": "0%7C1713186791495",
            "remixmsts": "%7B%22data%22%3A%5B%5B1713186841%2C%22mvk_navigation_pages%22%2C%22click%22%2C%22tabbar%22%2C%22/menu%22%2C%22mobile%22%5D%2C%5B1713186841%2C%22counters_check_tns%22%2C%22other%22%2C%22other%22%2C%22menu%22%5D%2C%5B1713186841%2C%22counters_check%22%2C1%5D%2C%5B1713186872%2C%22mvk_navigation_pages%22%2C%22click%22%2C%22tabbar%22%2C%22/audio%22%2C%22mobile%22%5D%5D%2C%22uniqueId%22%3A174385113.63533244%7D",
            "remixpuad": "JkSqDyOwi72H-CPajdDz2uUDl2f5yZ-sC3zdK6Hwch0",
            "remixq_9871cd6428ae6d80b1cb218a2b596cc9": "72959de5b0b80a6964",

            "remixnsid":"vk1.a.UCzlateaRlGm7TmTdKA8AbrRVOyg4a7t53GcqfMdpbYH7Fu73RAMThU7Ddhex4RYyRIJgTcEyFeIYfejeNnMlelpT3blpyFGzmfiJRzlDhKKp_jBjxduiYnWBk6qUkOcm7hJ-vcAqBjhm1BL2ZY9S9kXL_XJ9cXwO5lg9gHb_BMxUQAMmEe5Yx9MH7D0z9a2",
            "remixsid":"1_vPRLGuCe1VUrRFRGiX_WXfRcXvTSu77jXV84lzfPDybHnQ3iUH3jSZFRE_2vVxUez2JziczS1KRJ10QIMgXycA"
        ]
    )

    func testList() async throws {
        let list = try await api.list()
        print(list.count)
    }

    func testUser() async throws {
        let user = try await api.checkAuthorize()
        guard let id = user.user?.id else {
            XCTFail("nonuathorized")
            return
        }
        print(user)
//        let plists = try await api.playlists(id: id)
//        let tr = try await api.audioPageRequest(act: plists[0].act ?? "", offset: 0)
//        print(tr)
//        let plist = try await api.list(playlist: plists[0])
//        print(plist.count)
    }
}

private final class Client: HttpClient {

    weak var tests: VKMusicAPITests?
    lazy var base = UrlSessionHttpClient(
        session: URLSession(configuration: .default, delegate: SessionDelegate(tests: tests), delegateQueue: nil)
    )

    init(tests: VKMusicAPITests? = nil) {
        self.tests = tests
    }

    func dataTask(_ req: SwiftHttp.HttpRequest) async throws -> SwiftHttp.HttpResponse {
        let result = try await base.dataTask(req)
        print(result.statusCode.rawValue)
        print(result.headers)
        result.headers["Set-Cookie"]?
            .components(separatedBy: ", ")
            .forEach {
                let splits = $0.split(separator: "=", maxSplits: 1)
                let name = String(splits[0])
                let value: String
                if splits[1].contains(";") {
                    value = String(splits[1].split(separator: ";", maxSplits: 1)[0])
                } else {
                    value = String(splits[1])
                }
                if value.lowercased() == "deleted" {
//                    tests?.api.webCookies[name] = nil
                } else {
                    tests?.api.webCookies[name] = value
                }
                if name == "remixnsid" || name == "remixsid" {
                    print("New cookies \(name): \(value)")
                }
            }
        if let json = try? JSON(from: result.data), let location = json.location.string {
            print("Location \(location)")
            
            print(json)
            
//        https://login.vk.com/?
//            role=pda_frame
//            _origin=https%3A%2F%2Fm.vk.com
//            ip_h=0ccd07c0d407a3cd4c
//            lrt=47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU
//            
//        https://login.vk.com/?
//            role=pda_frame
//            _origin=https%3A%2F%2Fm.vk.com
//            ip_h=0ccd07c0d407a3cd4c
//            lrt=47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU
//            _phash=ee9a8acd97152b8629fe93f26771844b
//            to=aHR0cHM6Ly9tLnZrLmNvbS9tZW51
            
            if let url = HttpUrl(string: location) {
                var request = HttpRawRequest(url: url)
                request.headers["Cookie"] = tests?.api.webCookies.map { "\($0.key)=\($0.value)" }.joined(separator: "; ")
                return try await dataTask(request)
            }
        }
        return result
    }

    func downloadTask(_ req: SwiftHttp.HttpRequest) async throws -> SwiftHttp.HttpResponse {
        try await base.downloadTask(req)
    }

    func uploadTask(_ req: SwiftHttp.HttpRequest) async throws -> SwiftHttp.HttpResponse {
        try await base.uploadTask(req)
    }
}

private final class SessionDelegate: NSObject, URLSessionTaskDelegate {

    weak var tests: VKMusicAPITests?

    init(tests: VKMusicAPITests? = nil) {
        self.tests = tests
    }

    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void
    ) {
        print(response.allHeaderFields)
        var request = request
        
        (response.allHeaderFields["Set-Cookie"] as? String)?
            .components(separatedBy: ", ")
            .forEach {
                let splits = $0.split(separator: "=", maxSplits: 1)
                let name = String(splits[0])
                let value: String
                if splits[1].contains(";") {
                    value = String(splits[1].split(separator: ";", maxSplits: 1)[0])
                } else {
                    value = String(splits[1])
                }
                if value.lowercased() == "deleted" {
//                    tests?.api.webCookies[name] = nil
                } else {
                    tests?.api.webCookies[name] = value
                }
                if name == "remixnsid" || name == "remixsid" {
                    print("New cookies \(name): \(value)")
                }
            }
        request.url?.append(queryItems: [URLQueryItem(name: "__q_hash", value: "5d854e52765f27fc1cb0b57178488d2e")])
//        slogin_h=42cc35f9fd068cae70.2ebdb5c5aafaaa299f
//        role=fast
//        f=1
//        _phash=ee9a8acd97152b8629fe93f26771844b
//        to=aHR0cHM6Ly9tLnZrLmNvbS9tZW51
//        __q_hash=9871cd6428ae6d80b1cb218a2b596cc
//        
//        slogin_h=42cc35f9fd068cae70.2ebdb5c5aafaaa299f
//        role=fast
//        f=1
//        to=
//        niuh=1

        print("Redirect to", request.url)

        completionHandler(request)
    }
}
