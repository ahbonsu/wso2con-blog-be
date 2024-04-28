import ballerina/http;
import ballerina/io;

listener http:Listener ep0 = new (8081);


service /blog on ep0 {

    resource function get entries() returns EntriesResponse {
        io:println("foobar");
        
        // providing static answer
        Entry[] entries = [];

        foreach int i in 0 ... 9 {
            Entry entry = {
                author: "example-author" + i.toString(),
                timestamp: 1714304025,
                content: "hello world, example-" + i.toString()
            };
            entries[i] = entry;
        }

        return {
            body: {entries: entries}
        };
    }
}

public type Entry record {|
    string author;
    int timestamp;
    string content;
|};

public type EntriesResponse record {|
    *http:Ok;
    record {
        Entry[] entries;
    } body;
|};
