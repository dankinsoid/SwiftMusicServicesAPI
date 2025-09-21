import Foundation

public func amazonEnterCodeHTML(
	iconURL: String,
	title: String,
	url: String,
	code: String,
	textColor: String = "#fff",
	backgroundColor: String = "#000",
	tintColor: String = "#00aaff"
) -> String {
	"""
	<!DOCTYPE html>
	<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>\(title)</title>
	    <style>
	        body {
	            font-family: Arial, sans-serif;
	            background-color: \(backgroundColor);
	            color: \(textColor);
	            text-align: center;
	            display: flex;
	            flex-direction: column;
	            justify-content: center;
	            height: 100vh;
	        }
	        .container {
	            max-width: 600px;
	            margin: 0 auto;
	        }
	        .instructions {
	            font-size: 1.2em;
	        }
	        .code {
	            font-size: 2em;
	            font-weight: bold;
	            color: \(tintColor);
	        }
	        a {
	            color: \(tintColor);
	            text-decoration: none;
	        }
	        img {
	            width: 100px;
	            margin-bottom: 20px;
	        }
	    </style>
	</head>
	<body>
	    <div class="container">
	        <img src="\(iconURL)" alt="Amazon OAuth Icon">
	        <h1>\(title)</h1>
	        <p class="instructions">Go to <a href="\(url)" target="_blank">\(url)</a> on your smartphone, computer, or tablet and enter this code:</p>
	        <p class="code">\(code)</p>
	    </div>
	</body>
	</html>
	"""
}
