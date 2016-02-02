# AnyArchiver

Sample code demonstrating the advantage of using protocols.

### Requirements

Xcode 7.2, Swift 2.1, Carthage

### Setup

1. make sure you have [Carthage](https://github.com/Carthage/Carthage) installed
2. go to the repo folder, then run

    ```
    $ carthage bootstrap --platform mac
    ```

Now you should be able to build the project for OSX.

### Viewing the samples

The evolution of the code can be followed along the branches `step0` to `step4`.

* step 0: naive implementation
* step 1: first refactor with protocols
* step 2: removing ZipZap-dependent stuff from the framework
* step 3: extending functionality and adding a new implementor
* step 4: achieving complete separation of concerns
