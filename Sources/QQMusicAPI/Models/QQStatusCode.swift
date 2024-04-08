import Foundation

public struct QQStatusCode: RawRepresentable, ExpressibleByIntegerLiteral, Codable, Hashable {

    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public init(from decoder: Decoder) throws {
        rawValue = try Int(from: decoder)
    }

    public init(integerLiteral value: Int) {
        self.init(rawValue: value)
    }

    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }

    /// success
    public static let success: QQStatusCode = 0
    /// RPC routing protocol encoding exception
    public static let rpcRoutingProtocolEncodingException: QQStatusCode = 600001
    /// RPC routing protocol encoding exception
    public static let rpcRoutingProtocolEncodingException2: QQStatusCode = 600002
    /// RPC routing protocol encoding agnostic exception
    public static let rpcRoutingProtocolEncodingAgnosticException: QQStatusCode = 600003
    /// Login protocol encoding exception
    public static let loginProtocolEncodingException: QQStatusCode = 600101
    /// Login protocol encoding exception
    public static let loginProtocolEncodingException2: QQStatusCode = 600102
    /// Login protocol encoding agnostic exception
    public static let loginProtocolEncodingAgnosticException: QQStatusCode = 600103
    /// Authentication protocol encoding abnormality
    public static let authenticationProtocolEncodingAbnormality: QQStatusCode = 600201
    /// Authentication protocol encoding abnormality
    public static let authenticationProtocolEncodingAbnormality2: QQStatusCode = 600202
    /// Authentication protocol encoding agnostic exception
    public static let authenticationProtocolEncodingAgnosticException: QQStatusCode = 600203
    /// RPC service protocol encoding exception
    public static let rpcServiceProtocolEncodingException: QQStatusCode = 600301
    /// RPC service protocol encoding exception
    public static let rpcServiceProtocolEncodingException2: QQStatusCode = 600302
    /// RPC service protocol encoding agnostic exception
    public static let rpcServiceProtocolEncodingAgnosticException: QQStatusCode = 600303
    /// RPC service protocol version is not supported
    public static let rpcServiceProtocolVersionIsNotSupported: QQStatusCode = 600304
    /// Post length is too large
    public static let postLengthIsTooLarge: QQStatusCode = 600400
    /// HTTP METHOD is not supported
    public static let httpMethodIsNotSupported: QQStatusCode = 600401
    /// The interface parameter version is not supported
    public static let theInterfaceParameterVersionIsNotSupported: QQStatusCode = 600402
    /// http context parsing error
    public static let httpContextParsingError: QQStatusCode = 600403
    /// Wrong json format
    public static let wrongJsonFormat: QQStatusCode = 600404
    /// Rpc management route failed
    public static let rpcManagementRouteFailed: QQStatusCode = -500100
    /// Login routing failed
    public static let loginRoutingFailed: QQStatusCode = -500200
    /// Permission routing failed
    public static let permissionRoutingFailed: QQStatusCode = -500300
    /// Function Api routing failed
    public static let functionApiRoutingFailed: QQStatusCode = -500400
    /// RPC routing protocol decoding exception
    public static let rpcRoutingProtocolDecodingException: QQStatusCode = -600001
    /// RPC routing protocol decoding exception
    public static let rpcRoutingProtocolDecodingException2: QQStatusCode = -600002
    /// RPC routing protocol decoding agnostic exception
    public static let rpcRoutingProtocolDecodingAgnosticException: QQStatusCode = -600003
    /// Login protocol decoding exception
    public static let loginProtocolDecodingException: QQStatusCode = -600101
    /// Login protocol decoding exception
    public static let loginProtocolDecodingException2: QQStatusCode = -600102
    /// Login protocol decoding agnostic exception
    public static let loginProtocolDecodingAgnosticException: QQStatusCode = -600103
    /// Authentication protocol decoding exception
    public static let authenticationProtocolDecodingException: QQStatusCode = -600201
    /// Authentication protocol decoding exception
    public static let authenticationProtocolDecodingException2: QQStatusCode = -600202
    /// Authentication protocol decoding agnostic exception
    public static let authenticationProtocolDecodingAgnosticException: QQStatusCode = -600203
    /// Function API protocol decoding exception
    public static let functionAPIProtocolDecodingException: QQStatusCode = -600301
    /// Function API protocol decoding exception
    public static let functionAPIProtocolDecodingException2: QQStatusCode = -600302
    /// Function API protocol decoding agnostic exception
    public static let functionAPIProtocolDecodingAgnosticException: QQStatusCode = -600303
    /// RPC service connection failed
    public static let rpcServiceConnectionFailed: QQStatusCode = -700001
    /// RPC service send failed
    public static let rpcServiceSendFailed: QQStatusCode = -700002
    /// RPC service recv failed
    public static let rpcServiceRecvFailed: QQStatusCode = -700003
    /// RPC service package check failed
    public static let rpcServicePackageCheckFailed: QQStatusCode = -700004
    /// RPC service timeout
    public static let rpcServiceTimeout: QQStatusCode = -700005
    /// RPC service failed to create socket
    public static let rpcServiceFailedToCreateSocket: QQStatusCode = -700006
    /// RPC service AttachPoller failed
    public static let rpcServiceAttachPollerFailed: QQStatusCode = -700007
    /// RPC service illegal status
    public static let rpcServiceIllegalStatus: QQStatusCode = -700008
    /// RPC service Hangup event occurs
    public static let rpcServiceHangupEventOccurs: QQStatusCode = -700009
    /// RPC service peer closes connection
    public static let rpcServicePeerClosesConnection: QQStatusCode = -700010
    /// RPC service encoding error
    public static let rpcServiceEncodingError: QQStatusCode = -700011
    /// RPC service illegal route configuration type
    public static let rpcServiceIllegalRouteConfigurationType: QQStatusCode = -700012
    /// RPC service Msg processing timeout
    public static let rpcServiceMsgProcessingTimeout: QQStatusCode = -700013
    /// RPC service failed to obtain route
    public static let rpcServiceFailedToObtainRoute: QQStatusCode = -700014
    /// Login service connection failed
    public static let loginServiceConnectionFailed: QQStatusCode = -700101
    /// Login service send failed
    public static let loginServiceSendFailed: QQStatusCode = -700102
    /// Login service recv failed
    public static let loginServiceRecvFailed: QQStatusCode = -700103
    /// Login service pack check failed
    public static let loginServicePackCheckFailed: QQStatusCode = -700104
    /// Login service timeout
    public static let loginServiceTimeout: QQStatusCode = -700105
    /// Login service failed to create socket
    public static let loginServiceFailedToCreateSocket: QQStatusCode = -700106
    /// Login service AttachPoller failed
    public static let loginServiceAttachPollerFailed: QQStatusCode = -700107
    /// Login service illegal status
    public static let loginServiceIllegalStatus: QQStatusCode = -700108
    /// Login service Hangup event occurs
    public static let loginServiceHangupEventOccurs: QQStatusCode = -700109
    /// Log in to the service peer and close the connection.
    public static let loginServicePeerAndCloseConnection: QQStatusCode = -700110
    /// Login service encoding error
    public static let loginServiceEncodingError: QQStatusCode = -700111
    /// Login service illegal routing configuration type
    public static let loginServiceIllegalRoutingConfigurationType: QQStatusCode = -700112
    /// Login service Msg processing timeout
    public static let loginServiceMsgProcessingTimeout: QQStatusCode = -700113
    /// Login service failed to obtain route
    public static let loginServiceFailedToObtainRoute: QQStatusCode = -700114
    /// Access control service connection failed
    public static let accessControlServiceConnectionFailed: QQStatusCode = -700201
    /// Permission control service send failed
    public static let permissionControlServiceSendFailed: QQStatusCode = -700202
    /// Access control service recv failed
    public static let accessControlServiceRecvFailed: QQStatusCode = -700203
    /// Access Control Service Pack Check Failed
    public static let accessControlServicePackCheckFailed: QQStatusCode = -700204
    /// Permission control service timeout
    public static let permissionControlServiceTimeout: QQStatusCode = -700205
    /// Access control service failed to create socket
    public static let accessControlServiceFailedToCreateSocket: QQStatusCode = -700206
    /// Access control service AttachPoller failed
    public static let accessControlServiceAttachPollerFailed: QQStatusCode = -700207
    /// Access control service illegal status
    public static let accessControlServiceIllegalStatus: QQStatusCode = -700208
    /// The permission control service Hangup event occurs
    public static let permissionControlServiceHangupEventOccurs: QQStatusCode = -700209
    /// Access control service peer closes connection
    public static let accessControlServicePeerClosesConnection: QQStatusCode = -700210
    /// Access control service encoding error
    public static let accessControlServiceEncodingError: QQStatusCode = -700211
    /// Illegal routing configuration type of permission control service
    public static let illegalRoutingConfigurationTypeOfPermissionControlService: QQStatusCode = -700212
    /// Access control service Msg processing timeout
    public static let accessControlServiceMsgProcessingTimeout: QQStatusCode = -700213
    /// Access control service failed to obtain route
    public static let accessControlServiceFailedToObtainRoute: QQStatusCode = -700214
    /// api function service connection failed
    public static let apiFunctionServiceConnectionFailed: QQStatusCode = -700301
    /// api function service send failed
    public static let apiFunctionServiceSendFailed: QQStatusCode = -700302
    /// api function service recv failed
    public static let apiFunctionServiceRecvFailed: QQStatusCode = -700303
    /// api function service package check failed
    public static let apiFunctionServicePackageCheckFailed: QQStatusCode = -700304
    /// api function service timeout
    public static let apiFunctionServiceTimeout: QQStatusCode = -700305
    /// API function service failed to create socket
    public static let apiFunctionServiceFailedToCreateSocket: QQStatusCode = -700306
    /// api function service AttachPoller failed
    public static let apiFunctionServiceAttachPollerFailed: QQStatusCode = -700307
    /// api function service illegal status
    public static let apiFunctionServiceIllegalStatus: QQStatusCode = -700308
    /// API function service Hangup event occurs
    public static let apiFunctionServiceHangupEventOccurs: QQStatusCode = -700309
    /// api function service peer closes connection
    public static let apiFunctionServicePeerClosesConnection: QQStatusCode = -700310
    /// api function service coding error
    public static let apiFunctionServiceCodingError: QQStatusCode = -700311
    /// api function service illegal routing configuration type
    public static let apiFunctionServiceIllegalRoutingConfigurationType: QQStatusCode = -700312
    /// api function service Msg processing timeout
    public static let apiFunctionServiceMsgProcessingTimeout: QQStatusCode = -700313
    /// api function service failed to obtain route
    public static let apiFunctionServiceFailedToObtainRoute: QQStatusCode = -700314
    /// The interface initialization failed or the dependent service initialization failed.
    public static let interfaceInitializationFailedOrDependentServiceInitializationFailed: QQStatusCode = 10100
    /// The interface input parameter is illegal
    public static let interfaceInputParameterIsIllegal: QQStatusCode = 10101
    /// No access to the interface
    public static let noAccessToTheInterface: QQStatusCode = 10200
    /// Access interface IP is restricted
    public static let accessInterfaceIpIsRestricted: QQStatusCode = 10201
    /// An error occurred while requesting authentication service
    public static let anErrorOccurredWhileRequestingAuthenticationService: QQStatusCode = 10202
    /// The request for authentication signature is illegal
    public static let theRequestForAuthenticationSignatureIsIllegal: QQStatusCode = 10203
    /// Request frequency limit
    public static let requestFrequencyLimit: QQStatusCode = 10204
    /// Login status verification failed
    public static let loginStatusVerificationFailed: QQStatusCode = 10300
    /// WX scan code CODE is empty
    public static let wxScanCodeCodeIsEmpty: QQStatusCode = 10400
    /// Failed to obtain WeChat openid, access_token, refresh_token from WeChat backend
    public static let failedToObtainWeChatOpenidAccessTokenRefreshTokenFromWeChatBackend: QQStatusCode = 10401
    /// Get WeChat UNIONID is empty
    public static let getWeChatUnionidIsEmpty: QQStatusCode = 10402
    /// Obtain WeChat UNIONID binding MUSIC ID error
    public static let obtainWeChatUnionidBindingMusicIdError: QQStatusCode = 10403
    /// Obtaining WeChat MUSIC ID value is illegal
    public static let obtainingWeChatMusicIdValueIsIllegal: QQStatusCode = 10404
    /// The entered WeChat MUSIC ID value is illegal
    public static let theEnteredWeChatMusicIdValueIsIllegal: QQStatusCode = 10405
    /// Refreshing WeChat SECRET value verification is illegal
    public static let refreshingWeChatSecretValueVerificationIsIllegal: QQStatusCode = 10406
    /// The input WeChat SECRET value is empty
    public static let theInputWeChatSecretValueIsEmpty: QQStatusCode = 10407
    /// Enter WeChat MUSICKEY value is empty
    public static let enterWeChatMusickeyValueIsEmpty: QQStatusCode = 10408
    /// Enter WeChat to refresh the REFRESH_TOKEN value of MUSICKEY which is empty.
    public static let enterWeChatToRefreshTheRefreshTokenValueOfMusickeyWhichIsEmpty: QQStatusCode = 10409
    /// Failed to refresh MUSICKEY in the background
    public static let failedToRefreshMusickeyInTheBackground: QQStatusCode = 10410
    /// Request to generate MUSICKEY failed
    public static let requestToGenerateMusickeyFailed: QQStatusCode = 10411
    /// Generating MUSICKEY is illegal
    public static let generatingMusickeyIsIllegal: QQStatusCode = 10412
    /// Error getting user information
    public static let errorGettingUserInformation: QQStatusCode = 10413
    /// The openid parameter of the third-party business party's WeChat user is illegal
    public static let theOpenidParameterOfTheThirdPartyBusinessPartysWeChatUserIsIllegal: QQStatusCode = 10414
    /// The WeChat appid parameter of the third-party business party is illegal
    public static let theWeChatAppidParameterOfTheThirdPartyBusinessPartyIsIllegal: QQStatusCode = 10415
    /// The WeChat ACCESS_TOKEN parameter under the third-party business party is illegal
    public static let theWeChatAccessTokenParameterUnderTheThirdPartyBusinessPartyIsIllegal: QQStatusCode = 10416
    /// The third-party business party's joint binding with QQ Music failed to log in.
    public static let theThirdPartyBusinessPartysJointBindingWithQQMusicFailedToLogIn: QQStatusCode = 10417
    /// After the third-party business party and QQ Music jointly bind and log in, the music account information is empty.
    public static let afterTheThirdPartyBusinessPartyAndQQMusicJointlyBindAndLogInTheMusicAccountInformationIsEmpty: QQStatusCode = 10418
    /// WeChat login status verification failed
    public static let weChatLoginStatusVerificationFailed: QQStatusCode = 10500
    /// Third-party login status verification failed
    public static let thirdPartyLoginStatusVerificationFailed: QQStatusCode = 10600
    /// Login method is not supported
    public static let loginMethodIsNotSupported: QQStatusCode = 10700
    /// This interface must be logged in before it can be used
    public static let thisInterfaceMustBeLoggedInBeforeItCanBeUsed: QQStatusCode = 10701
    /// Failed to obtain OPI paid membership information
    public static let failedToObtainOpiPaidMembershipInformation: QQStatusCode = 10800
    /// Users who are not OPI paying members
    public static let usersWhoAreNotOpiPayingMembers: QQStatusCode = 10801
    /// Under joint login, the user login method is not supported.
    public static let underJointLoginTheUserLoginMethodIsNotSupported: QQStatusCode = 11100
    /// Under joint login, the device login method is not supported.
    public static let underJointLoginTheDeviceLoginMethodIsNotSupported: QQStatusCode = 11101
    /// Under joint login, user login verification failed.
    public static let underJointLoginUserLoginVerificationFailed: QQStatusCode = 11102
    /// Under joint login, user Internet login verification failed.
    public static let underJointLoginUserInternetLoginVerificationFailed: QQStatusCode = 11103
    /// Under joint login, WeChat user Internet login verification failed
    public static let underJointLoginWeChatUserInternetLoginVerificationFailed: QQStatusCode = 11104
    /// Under joint login, device login verification failed.
    public static let underJointLoginDeviceLoginVerificationFailed: QQStatusCode = 11105
    /// Under federated login, the device or user needs to be logged in
    public static let underFederatedLoginTheDeviceOrUserNeedsToBeLoggedIn: QQStatusCode = 11106
    /// Under joint login, the interface does not support device-only login.
    public static let underJointLoginTheInterfaceDoesNotSupportDeviceOnlyLogin: QQStatusCode = 11107
    /// Under joint login, the QQ Music client QPlay Auth authorization login verification failed.
    public static let underJointLoginTheQQMusicClientQPlayAuthAuthorizationLoginVerificationFailed: QQStatusCode = 11108
    /// QQ Music open account system verification failed under QQ Music QPlay Auth authorized login.
    public static let qqMusicOpenAccountSystemVerificationFailedUnderQQMusicQPlayAuthAuthorizedLogin: QQStatusCode = 11109
    /// Error querying RPC configuration
    public static let errorQueryingRpcConfiguration: QQStatusCode = 11200
    /// The parsing configuration protocol is illegal
    public static let theParsingConfigurationProtocolIsIllegal: QQStatusCode = 11201
    /// Parsing JSON configuration exception
    public static let parsingJsonConfigurationException: QQStatusCode = 11202
    /// Unknown exception in parsing JSON configuration
    public static let unknownExceptionInParsingJsonConfiguration: QQStatusCode = 11203
    /// RPC does not exist
    public static let rpcDoesNotExist: QQStatusCode = 11204
    /// RPC request to take down
    public static let rpcRequestToTakeDown: QQStatusCode = 11205
    /// RPC routing configuration issues
    public static let rpcRoutingConfigurationIssues: QQStatusCode = 11206
    /// The request environment of RPC is unknown
    public static let theRequestEnvironmentOfRpcIsUnknown: QQStatusCode = 11207
    /// RPC request region is unknown
    public static let rpcRequestRegionIsUnknown: QQStatusCode = 11208
    /// RPC similarity does not match the access
    public static let rpcSimilarityDoesNotMatchTheAccess: QQStatusCode = 11209
    /// Error for unknown reason
    public static let errorForUnknownReason: QQStatusCode = 11210
    /// Rpc empty implementation
    public static let rpcEmptyImplementation: QQStatusCode = 110120110
    /// Cgi incoming parameter version is not supported
    public static let cgiIncomingParameterVersionIsNotSupported: QQStatusCode = 110120111
    /// Failed to parse the incoming json parameter
    public static let failedToParseTheIncomingJsonParameter: QQStatusCode = 110120112
    /// jce failed to output json
    public static let jceFailedToOutputJson: QQStatusCode = 110120113
    /// Encoding json exception
    public static let encodingJsonException: QQStatusCode = -200312
    /// Coding jce exception
    public static let codingJceException: QQStatusCode = -200313
    /// Decoding json exception
    public static let decodingJsonException: QQStatusCode = -200314
    /// Decoding jce exception
    public static let decodingJceException: QQStatusCode = -200315
    /// Cgi incoming parameter version does not match
    public static let cgiIncomingParameterVersionDoesNotMatch: QQStatusCode = -200316
    /// Failed to parse the incoming json parameter
    public static let failedToParseTheIncomingJsonParameter2: QQStatusCode = -200317
    /// Parameter parsing unknown exception
    public static let parameterParsingUnknownException: QQStatusCode = -200400

    /// Error getting ranking information
    public static let errorGettingRankingInformation: QQStatusCode = 100301
    /// Error in parsing ranking information
    public static let errorInParsingRankingInformation: QQStatusCode = 100302
}
