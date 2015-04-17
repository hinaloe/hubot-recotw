# hubot-recotw

Register and view the Tweets having dark history from [RecoTw](http://recotw.black/)

see [`src/recotw.coffee`](src/recotw.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-recotw --save`

Then add **hubot-recotw** to your `external-scripts.json`:

```json
[
  "hubot-recotw"
]
```

## Sample Interaction

```
user1>> hubot black
hubot>> kb10uy: よし http://t.co/wiUsLuF0Nr https://twitter.com/kb10uy/status/500616868076326912
user1>> hubot black kb10uy
hubot>> kb10uy: grepがグレープを食べてgawk(ゴクッ) https://twitter.com/kb10uy/status/512626259767992321
user1>> hubot latest-black
hubot>> java_shit: 女性に痴漢されたい（言い直し） https://twitter.com/java_shit/status/588973414590775296

```
