
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

## License

This git repository is MIT.
Licenses for all of the software in the Docker image are in the image itself.
