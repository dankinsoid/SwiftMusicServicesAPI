cd "${SRCROOT}"
find . -name ".DS_Store" -delete
case $1 in
SoundCloud)
    JS_SCRIPT_URL="https://developers.soundcloud.com/docs/api/explorer/swagger-ui-init.js"
    JSON_FILE_PATH="extracted.json"

    # Download the JS script
    curl -s "$JS_SCRIPT_URL" > downloaded_script.js

    # Use awk to remove prefix and suffix
    awk '/"swaggerDoc":/ {print; flag=1; next} /"customOptions": {/ {flag=0} flag {print}' downloaded_script.js > temp.json

    # Now, instead of removing the first and last lines, 
    # we specifically target and remove only the unwanted prefix and suffix patterns
    # Remove the leading content before and including "swaggerDoc":
    sed -i -e 's/"swaggerDoc"://g' temp.json
    # Remove trailing new lines and comma from the end of the file
    perl -pi -e 'chomp if eof' temp.json
    perl -pi -e 's/,$// if eof' temp.json

    mv temp.json "$JSON_FILE_PATH"
    rm temp.json

    # Check if JSON file is not empty
    if [ -s "$JSON_FILE_PATH" ]; then
        # Call swaggen generate with the extracted JSON file URL
        swaggen generate "$JSON_FILE_PATH" --destination "Sources/$1API/" --template "SwagGen_Template/template.yml" --option "name: $1"

        # Delete the downloaded script and extracted JSON file
        rm downloaded_script.js
        # rm $JSON_FILE_PATH
    else
        echo "❌ No matching substring found or JSON file is empty."
    exit 1
    fi
    ;;
*)
    echo "❌ $1 API not found"
    exit 1
    ;;
esac
swiftformat Sources/$1API
echo "✅ $1 API generated"