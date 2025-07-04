
# XML Validator Container

This container allows you to validate XML files using XSD.
It also has the MusicXML schemas since that is what I am validating.

Example:

```sh
docker run --rm \
    -v "${HOME}/xmlfiles:/files" \
    xmllint \
        --noout \
        --nonet \
        --schema /files/schema.xsd \
        /files/file.xml 
```

## Building and Testing

Run `./test/test.sh` to build the container and run the tests.
If you inspect that script, you can see the build command.
The script will build the image and give it the tag `ghcr.io/webern/xmlvalidator:testing`.

## License

This git repository is MIT.
Licenses for all the software in the Docker image are in the image itself.
