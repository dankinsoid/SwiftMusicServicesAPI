import Foundation
import SimpleCoders
import SwiftHttp
import SwiftMusicServicesApi
import VDCodable

public extension E3U {
	static func publicInit(
		lines: [Line]
	) -> Self {
		.init(
			lines: lines
		)
	}
}

public extension E3U.Formatter {
	static func publicInit(
		fileStart: String = "#EXTM3U",
		lineStart: String = "#EXTINF:"
	) -> Self {
		.init(
			fileStart: fileStart,
			lineStart: lineStart
		)
	}
}

public extension E3U.Line {
	static func publicInit(
		duration: Int,
		artist: String,
		title: String
	) -> Self {
		.init(
			duration: duration,
			artist: artist,
			title: title
		)
	}
}

public extension Yandex.Music.API.ImportCodeOutput {
	static func publicInit(
		status: RawEnum<Status>,
		tracks: [YMO.Track]? = nil
	) -> Self {
		.init(
			status: status,
			tracks: tracks
		)
	}
}

public extension Yandex.Music.API.ImportFileOutput {
	static func publicInit(
		importCode: String
	) -> Self {
		.init(
			importCode: importCode
		)
	}
}

public extension Yandex.Music.API.PassportTokenInput {
	static func publicInit(
		client_id: String,
		client_secret: String,
		grant_type: YM.API.GrantType = .x_token,
		access_token: String,
		payment_auth_retpath: String = "yandexmusic://am/payment_auth"
	) -> Self {
		.init(
			client_id: client_id,
			client_secret: client_secret,
			grant_type: grant_type,
			access_token: access_token,
			payment_auth_retpath: payment_auth_retpath
		)
	}
}

public extension Yandex.Music.API.PlaylistsChangeInput {
	static func publicInit(
		kind: Int,
		revision: Int,
		diff: [Diff],
		mixed: Bool = false
	) -> Self {
		.init(
			kind: kind,
			revision: revision,
			diff: diff,
			mixed: mixed
		)
	}
}

public extension Yandex.Music.API.PlaylistsChangeInput.Diff {
	static func publicInit(
		op: YMO.Operation = YMO.Operation.insert,
		at: Int,
		tracks: [Track]
	) -> Self {
		.init(
			op: op,
			at: at,
			tracks: tracks
		)
	}
}

public extension Yandex.Music.API.PlaylistsChangeInput.Diff.Track {
	static func publicInit(
		id: String,
		albumId: String? = nil
	) -> Self {
		.init(
			id: id,
			albumId: albumId
		)
	}
}

public extension Yandex.Music.API.PlaylistsCreateInput {
	static func publicInit(
		title: String,
		visibility: YMO.Visibility = .public
	) -> Self {
		.init(
			title: title,
			visibility: visibility
		)
	}
}

public extension Yandex.Music.API.SearchOutput {
	static func publicInit(
		misspellCorrected: Bool? = nil,
		nocorrect: Bool? = nil,
		searchRequestId: String? = nil,
		text: String? = nil,
		misspellResult: String? = nil,
		misspellOriginal: String? = nil,
		best: YMO.BestResult? = nil,
		albums: YMO.Results<YMO.Album>? = nil,
		artists: YMO.Results<YMO.Artist>? = nil,
		playlists: YMO.Results<YMO.Playlist<YMO.TrackShort>>? = nil,
		tracks: YMO.Results<YMO.Track>? = nil,
		videos: YMO.Results<YMO.Video>? = nil
	) -> Self {
		.init(
			misspellCorrected: misspellCorrected,
			nocorrect: nocorrect,
			searchRequestId: searchRequestId,
			text: text,
			misspellResult: misspellResult,
			misspellOriginal: misspellOriginal,
			best: best,
			albums: albums,
			artists: artists,
			playlists: playlists,
			tracks: tracks,
			videos: videos
		)
	}
}

public extension Yandex.Music.API.TokenOutput {
	static func publicInit(
		tokenType: String? = nil,
		accessToken: String,
		expiresIn: Int? = nil,
		uid: Int? = nil
	) -> Self {
		.init(
			tokenType: tokenType,
			accessToken: accessToken,
			expiresIn: expiresIn,
			uid: uid
		)
	}
}

public extension Yandex.Music.Objects.Account {
	static func publicInit(
		displayName: String,
		birthday: String? = nil,
		secondName: String? = nil,
		fullName: String? = nil,
		region: Int? = nil,
		registeredAt: Date? = nil,
		serviceAvailable: Bool? = nil,
		firstName: String? = nil,
		now: Date? = nil,
		passportPhones: [YMO.PassportPhone]? = nil,
		hostedUser: Bool? = nil,
		uid: Int,
		login: String? = nil
	) -> Self {
		.init(
			displayName: displayName,
			birthday: birthday,
			secondName: secondName,
			fullName: fullName,
			region: region,
			registeredAt: registeredAt,
			serviceAvailable: serviceAvailable,
			firstName: firstName,
			now: now,
			passportPhones: passportPhones,
			hostedUser: hostedUser,
			uid: uid,
			login: login
		)
	}
}

public extension Yandex.Music.Objects.AccountStatus {
	static func publicInit(
		subeditorLevel: Int? = nil,
		account: YMO.Account,
		permissions: YMO.Permissions? = nil,
		barBelow: YMO.BarBelow? = nil,
		defaultEmail: String? = nil,
		plus: YMO.Plus? = nil,
		subeditor: Bool? = nil,
		subscription: YMO.Subscription
	) -> Self {
		.init(
			subeditorLevel: subeditorLevel,
			account: account,
			permissions: permissions,
			barBelow: barBelow,
			defaultEmail: defaultEmail,
			plus: plus,
			subeditor: subeditor,
			subscription: subscription
		)
	}
}

public extension Yandex.Music.Objects.AutoRenewable {
	static func publicInit(
		productId: String,
		expires: Date? = nil,
		finished: Bool? = nil,
		vendorHelpUrl: String? = nil,
		vendor: String? = nil,
		product: YMO.Product,
		orderId: Int? = nil
	) -> Self {
		.init(
			productId: productId,
			expires: expires,
			finished: finished,
			vendorHelpUrl: vendorHelpUrl,
			vendor: vendor,
			product: product,
			orderId: orderId
		)
	}
}

public extension Yandex.Music.Objects.BarBelow {
	static func publicInit(
		bgColor: YMO.HEXColor? = nil,
		textColor: YMO.HEXColor? = nil,
		text: String? = nil,
		button: YMO.Button? = nil
	) -> Self {
		.init(
			bgColor: bgColor,
			textColor: textColor,
			text: text,
			button: button
		)
	}
}

public extension Yandex.Music.Objects.BestResult {
	static func publicInit(
		type: YMO.SearchType? = nil,
		result: YMO.Best
	) -> Self {
		.init(
			type: type,
			result: result
		)
	}
}

public extension Yandex.Music.Objects.Button {
	static func publicInit(
		bgColor: YMO.HEXColor? = nil,
		textColor: YMO.HEXColor? = nil,
		text: String? = nil,
		uri: String? = nil
	) -> Self {
		.init(
			bgColor: bgColor,
			textColor: textColor,
			text: text,
			uri: uri
		)
	}
}

public extension Yandex.Music.Objects.Counts {
	static func publicInit(
		tracks: Int,
		tdirectAlbums: Int,
		talsoAlbumspublic: Int,
		talsoTracks: Int
	) -> Self {
		.init(
			tracks: tracks,
			tdirectAlbums: tdirectAlbums,
			talsoAlbumspublic: talsoAlbumspublic,
			talsoTracks: talsoTracks
		)
	}
}

public extension Yandex.Music.Objects.Cover {
	static func publicInit(
		type: String? = nil,
		uri: String? = nil,
		custom: Bool? = nil,
		dir: String? = nil,
		version: String? = nil,
		itemsUri: [String]? = nil,
		prefix: String? = nil
	) -> Self {
		.init(
			type: type,
			uri: uri,
			custom: custom,
			dir: dir,
			version: version,
			itemsUri: itemsUri,
			prefix: prefix
		)
	}
}

public extension Yandex.Music.Objects.DownloadInfo {
	static func publicInit(
		codec: RawEnum<YMO.Codec>? = nil,
		bitrateInKbps: Int? = nil,
		gain: Bool? = nil,
		preview: Bool? = nil,
		downloadInfoUrl: String,
		direct: Bool? = nil
	) -> Self {
		.init(
			codec: codec,
			bitrateInKbps: bitrateInKbps,
			gain: gain,
			preview: preview,
			downloadInfoUrl: downloadInfoUrl,
			direct: direct
		)
	}
}

public extension Yandex.Music.Objects.Icon {
	static func publicInit(
		backgroundColor: YMO.HEXColor,
		imageUrl: String
	) -> Self {
		.init(
			backgroundColor: backgroundColor,
			imageUrl: imageUrl
		)
	}
}

public extension Yandex.Music.Objects.LibraryContainer {
	static func publicInit(
		library: YMO.Library
	) -> Self {
		.init(
			library: library
		)
	}
}

public extension Yandex.Music.Objects.NonAutoRenewableRemainder {
	static func publicInit(
		days: Int? = nil
	) -> Self {
		.init(
			days: days
		)
	}
}

public extension Yandex.Music.Objects.Owner {
	static func publicInit(
		uid: Int,
		login: String? = nil,
		name: String? = nil,
		sex: String? = nil,
		verified: Bool? = nil
	) -> Self {
		.init(
			uid: uid,
			login: login,
			name: name,
			sex: sex,
			verified: verified
		)
	}
}

public extension Yandex.Music.Objects.PassportPhone {
	static func publicInit(
		phone: String? = nil
	) -> Self {
		.init(
			phone: phone
		)
	}
}

public extension Yandex.Music.Objects.Permissions {
	static func publicInit(
		default: [String]? = nil,
		values: [String]? = nil,
		until: Date? = nil
	) -> Self {
		.init(
			default: `default`,
			values: values,
			until: until
		)
	}
}

public extension Yandex.Music.Objects.Plus {
	static func publicInit(
		hasPlus: Bool,
		isTutorialCompleted: Bool? = nil
	) -> Self {
		.init(
			hasPlus: hasPlus,
			isTutorialCompleted: isTutorialCompleted
		)
	}
}

public extension Yandex.Music.Objects.Price {
	static func publicInit(
		amount: Int,
		currency: String? = nil
	) -> Self {
		.init(
			amount: amount,
			currency: currency
		)
	}
}

public extension Yandex.Music.Objects.Product {
	static func publicInit(
		features: [String]? = nil,
		trialDuration: Int? = nil,
		productId: String,
		plus: Bool? = nil,
		feature: String? = nil,
		trialPeriodDuration: String? = nil,
		type: String? = nil,
		commonPeriodDuration: String? = nil,
		duration: Int? = nil,
		debug: Bool? = nil,
		price: YMO.Price
	) -> Self {
		.init(
			features: features,
			trialDuration: trialDuration,
			productId: productId,
			plus: plus,
			feature: feature,
			trialPeriodDuration: trialPeriodDuration,
			type: type,
			commonPeriodDuration: commonPeriodDuration,
			duration: duration,
			debug: debug,
			price: price
		)
	}
}

public extension Yandex.Music.Objects.Result {
	static func publicInit(
		result: T,
		invocationInfo: YMO.InvocationInfo? = nil
	) -> Self {
		.init(
			result: result,
			invocationInfo: invocationInfo
		)
	}
}

public extension Yandex.Music.Objects.Subscription {
	static func publicInit(
		canStartTrial: Bool,
		nonAutoRenewableRemainder: YMO.NonAutoRenewableRemainder? = nil,
		mcdonalds: Bool? = nil,
		autoRenewable: [YMO.AutoRenewable]? = nil
	) -> Self {
		.init(
			canStartTrial: canStartTrial,
			nonAutoRenewableRemainder: nonAutoRenewableRemainder,
			mcdonalds: mcdonalds,
			autoRenewable: autoRenewable
		)
	}
}

public extension Yandex.Music.Objects.Tag {
	static func publicInit(
		id: String,
		value: String
	) -> Self {
		.init(
			id: id,
			value: value
		)
	}
}

public extension Yandex.Music.Objects.TrackPosition {
	static func publicInit(
		volume: Int? = nil,
		index: Int? = nil
	) -> Self {
		.init(
			volume: volume,
			index: index
		)
	}
}

public extension Yandex.Music.Objects.Video {
	static func publicInit(
		youtubeUrl: String? = nil,
		thumbnailUrl: String? = nil,
		title: String,
		duration: Int? = nil,
		text: String? = nil,
		htmlAutoPlayVideoPlayer: String? = nil,
		regions: [String]? = nil
	) -> Self {
		.init(
			youtubeUrl: youtubeUrl,
			thumbnailUrl: thumbnailUrl,
			title: title,
			duration: duration,
			text: text,
			htmlAutoPlayVideoPlayer: htmlAutoPlayVideoPlayer,
			regions: regions
		)
	}
}

public extension YandexError {
	static func publicInit(
		error_description: String? = nil,
		error: String
	) -> Self {
		.init(
			error_description: error_description,
			error: error
		)
	}
}

public extension YandexErrorDescription {
	static func publicInit(
		name: String,
		message: String
	) -> Self {
		.init(
			name: name,
			message: message
		)
	}
}

public extension YandexFailure {
	static func publicInit(
		invocationInfo: YMO.InvocationInfo? = nil,
		error: YandexErrorDescription
	) -> Self {
		.init(
			invocationInfo: invocationInfo,
			error: error
		)
	}
}
