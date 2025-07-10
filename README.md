# Firebase Extensions iOS Demo App

This repository demonstrates how to incorporate [Stream's Firebase Extensions](https://extensions.dev/extensions?provider=stream) into an iOS app (using SwiftUI). Specifically, we're incorporating the [Authenticate with Stream Chat](https://extensions.dev/extensions/stream/auth-chat) extension.

What is the value of that?

- If we use an Auth Provider like [Firebase]https://firebase.google.com/) and [Stream Chat](https://github.com/GetStream/stream-chat-swift), we need to keep the users synced between the two. That is because to use Stream Chat we need to authenticate with the Stream services
- For that we need to (usually) build a server that manages users on the Stream Dashboard, and issues tokens that we can use inside our app for authentication
- The Firebase Extensions take all the server-side work away from us and we can focus on building our frontend app in peace

## How do the Extensions work?

In general, the Extensions are just [Cloud Functions](https://firebase.google.com/docs/functions) that the Stream team has built that everyone can install into their Firebase projects. They do what their naming suggests, so in the case of the _Authenticate with Stream Chat_ extension it does the following:

- It listens to whenever a Firebase user is _created_ and when that happens it adds it to the Stream Dashboard as well (with the same `userId` and accompanying data)
- Same goes for whenever a Firebase user is _deleted_, it will also sync with the Stream Dashboard to remove the user there as well
- It provides an endpoint (which is again a Cloud Function) to generate (and - less commonly - revoke) user tokens for signed-in users (necessary to authenticate with the Stream Dashboard)

If you want to learn more, read the accompanying [blog post]().

## How to run it locally?

- Clone the project locally through `git clone git@github.com:GetStream/firebase-extensions-iOS-demo.git`
- Open up Xcode and under the project's _Signing and Capabilities_ section add your team (and change the _Bundle Identifier_ if you want)
- Create a project in Firebase and create an app with a `GoogleService-Info.plist` file that you copy into the root of the project
- Create a Stream dashboard project and copy both the API key and the secret
- Install the [Authenticate with Stream Chat](https://extensions.dev/extensions/stream/auth-chat) extension (instructions are on the Extension's site) and set it up with your Stream project's credentials
- Inside the Xcode project, open up the `ChatViewModel` file and when calling the `ChatClientConfig` replace the `<your-api-key>` String with your Stream project's API key and the `<your-bundle-id>` for the `config.applicationGroupIdentifier` with your project's bundle ID
- Run the project and witness the magic first hand

## Where can I learn more?

- [Blog post]()
- [Stream's Swift SDK](https://getstream.io/chat/sdk/ios/)
- [SwiftUI Chat App Tutorial](https://getstream.io/tutorials/ios-chat/)
- [Stream's Video Calling SDK](https://getstream.io/video/docs/)
