#if canImport(SafariServices) && canImport(UIKit) && canImport(SwiftUI)
	import Combine
	import Foundation
	import YouTubeAPI
	import SwiftUI

/// Google OAuth 2.0 view
public struct YouTubeLoginView: View {

    private let url: URL?

    /// - Parameters:
    ///   - oauth: OAuth instance
    ///   - responseType: Determines whether the Google OAuth 2.0 endpoint returns an authorization code. Set the parameter value to `code` for web server applications.
    ///   - scope: A space-delimited list of scopes that identify the resources that your application could access on the user's behalf.
    ///   These values inform the consent screen that Google displays to the user. Scopes enable your application to only request access to the resources that it needs while also enabling users to control the amount of access that they grant to your application.
    ///   Thus, there is an inverse relationship between the number of scopes requested and the likelihood of obtaining user consent.
    ///   The [OAuth 2.0 API Scopes](https://developers.google.com/identity/protocols/oauth2/scopes) document provides a full list of scopes that you might use to access Google APIs.
    ///   - accessType: Recommended. Indicates whether your application can refresh access tokens when the user is not present at the browser. Valid parameter values are online, which is the default value, and offline.
    ///   Set the value to offline if your application needs to refresh access tokens when the user is not present at the browser. This is the method of refreshing access tokens described later in this document.
    ///   This value instructs the Google authorization server to return a refresh token and an access token the first time that your application exchanges an authorization code for tokens.
    ///   - state: Specifies any string value that your application uses to maintain state between your authorization request and the authorization server's response.
    ///   The server returns the exact value that you send as a name=value pair in the URL query component (?) of the redirect_uri after the user consents to or denies your application's access request.
    ///   You can use this parameter for several purposes, such as directing the user to the correct resource in your application, sending nonces, and mitigating cross-site request forgery.
    ///   Since your redirect_uri can be guessed, using a state value can increase your assurance that an incoming connection is the result of an authentication request.
    ///   If you generate a random string or encode the hash of a cookie or another value that captures the client's state, you can validate the response to additionally ensure that the request and response originated in the same browser, providing protection against attacks such as [cross-site request forgery](https://datatracker.ietf.org/doc/html/rfc6749#section-10.12).
    ///   See the [OpenID Connect documentation](https://developers.google.com/identity/protocols/oauth2/openid-connect#createxsrftoken) for an example of how to create and confirm a state token.
    ///   - includeGrantedScopes: Enables applications to use incremental authorization to request access to additional scopes in context.
    ///   If you set this parameter's value to `true` and the authorization request is granted, then the new access token will also cover any scopes to which the user previously granted the application access.
    ///   See the [incremental authorization section](https://developers.google.com/youtube/v3/guides/auth/server-side-web-apps#incrementalAuth) for examples.
    ///   - enableGranularConsent: Defaults to `true`. If set to false, [more granular Google Account permissions](https://developers.google.com/identity/protocols/oauth2/resources/granular-permissions) will be disabled for OAuth client IDs created before 2019.
    ///   No effect for newer OAuth client IDs, since more granular permissions is always enabled for them.
    ///   - loginHint: If your application knows which user is trying to authenticate, it can use this parameter to provide a hint to the Google Authentication Server.
    ///   The server uses the hint to simplify the login flow either by prefilling the email field in the sign-in form or by selecting the appropriate multi-login session.
    ///   Set the parameter value to an email address or sub identifier, which is equivalent to the user's Google ID.
    ///   - prompt: A list of prompts to present the user. If you don't specify this parameter, the user will be prompted only the first time your project requests access.
    ///   See [Prompting re-consent](https://developers.google.com/identity/protocols/oauth2/openid-connect#re-consent) for more information
    ///   - codeChallengeMethod: Specifies what method was used to encode a `code_verifier` that will be used during authorization code exchange.
    ///   The only supported values for this parameter are S256 or plain. When nil PCKE auth is not used.   .
    public init(
        oauth: YouTube.OAuth2,
        responseType: String = "code",
        scope: [YouTube.Scope],
        accessType: YouTube.Objects.AccessType? = .offline,
        state: String?,
        includeGrantedScopes: Bool? = nil,
        enableGranularConsent: Bool? = nil,
        loginHint: String? = nil,
        prompt: [YouTube.Objects.Prompt]? = nil,
        codeChallengeMethod: CodeChallengeMethod? = nil
    ) {
        // authURL should never throw
        url = try? oauth.authURL(
            responseType: responseType,
            scope: scope,
            accessType: accessType,
            state: state,
            includeGrantedScopes: includeGrantedScopes,
            enableGranularConsent: enableGranularConsent,
            loginHint: loginHint,
            prompt: prompt,
            codeChallengeMethod: codeChallengeMethod
        )
    }

    public var body: some View {
        if let url {
            SafariView(url: url)
        }
    }
}

private struct SafariView: UIViewControllerRepresentable {

    let url: URL
    
    func makeUIViewController(context _: Context) -> SafariViewController {
        SafariViewController(url: url)
    }
    
    func updateUIViewController(_: SafariViewController, context _: Context) {}
}

public extension View {

    func onYouTubeLogin(_ success: @escaping () -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: .youTubeLoginSuccessful)) { _ in
            success()
        }
    }
}
#endif
