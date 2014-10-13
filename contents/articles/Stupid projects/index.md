---
title: Stupid projects
author: franc
date: 2014-10-13
template: article.jade
---

_"Nothing useless can be truly beautiful."_
--**William Morris**

Projects that you take on your free time, as opposed to comissioned projects, can be of different sorts. Some are born with the goal to explore and research topics without a specific output to produce. Some are born with a purely artistic or even aesthetic intention. Others are totally an excuse to learn new tools, methods.

For this last type, I find it useful to imagine completely stupid and missionless projects by piling up pieces of things you'd like to learn.

Let's say I have a serious project in mind. My goal involves using **Twitter bots** that can publicize and create awareness on a social project (like stop-and-frisk). I'm doing some research looking for public data, looking for an angle in, but I haven't quite figured out a way to make something useful for that cause. 

Good is to step back and instead of staying in the seriousness when your point is not well defined, let's do something to make sure all the pieces are well tied together. Let's say I also want to learn a little bit of **Node.js**. And just for the fun of it, let's say I've been wanting to learn how to use a couple of features of the **SoundCloud API**, to keep track of my Likes (because SoundCloud's UI is beautiful but not very reliable) as well as explore some designy features of SVG.

All those things together don't seem to make much sense, but I'm still going to come up with a way to link them as an excuse to learn. This is what is technically referred to as a _stupid_ project.

Stupid projects are the best because they put little pressure on being coherent, smart and making solid points, and allow you to focus on the technical aspects and make little tutorials out of it.

So here's a list of the pieces I'm trying to pile up. 

+ Create a Twitter bot using Node. [Here](http://www.apcoder.com/2013/10/03/twitter-bot-20-minutes-node-js/)'s a super simple way to do that with a module called [twit](https://github.com/ttezel/twit).
	- Apparently to create a Twitter account you need a unique email address (which, if you own a domain, shouldn't be an issue) and a unique telephone number. Which is an issue, because I only own a cell phone (I know, weird right?). To give a twitter bot Write access via a centralized twitter account, follow [this](http://dghubble.com/blog/posts/twitter-app-write-access-and-bots/). 
	- I suspect this last thing allows for the _automation_ of creating twitter accounts (for noble missions like spam and fake accounts), but this is not my goal, so I won't explore that for now.
+ My Node script will check once a day whether I have liked new shit on SoundCloud using [this module](https://www.npmjs.org/package/soundcloud-node), and scrape that song down using a module called [SoundScrape](https://github.com/dmotz/soundscrape).
+ Using a [Node implementation of the HTML5's Web Audio API](https://github.com/sebpiq/node-web-audio-api), I'll load the data of the audio file, sample it and draw a Time Domain area chart as SVG, apply a blur effect to a point it's totally unrecognizeable and tweet the image.

So stupid.

![Soundscape](soundscape.png)
