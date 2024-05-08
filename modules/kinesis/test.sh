#!/bin/bash

aws kinesis put-record --stream-name "test-stream" --data $(echo -n "hello world" | base64) --partition-key "1"