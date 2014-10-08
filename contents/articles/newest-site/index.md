---
title: I rennovated my site
author: Franc
date: 2013-12-27
template: article.jade
---

I've been wanting to do a lot more writing for a long time. Last year I redesigned my personal site and I ambitiously started two blogs, one for visualization ideas and tutorials, interaction and so on, which I called Patterns, and another for more free creative writing, which I called No Patterns. Both were self-hosted Wordpress. I adjusted the visual design and hosted them on together with the rest of my main site so it could be experience without friction once you had accessed it. And while I think it worked for a bit, both for me as a writer and for people who would visit it, I decided I needed to lower the barrier even more to get myself to write regularly. Either that, or integrate writing so much into my site that it would be embarrassing to not update regularly.

I redesigned the whole site by using [Wintersmith](http://wintersmith.io/), a static site generator based on [Jade](http://jade-lang.com), a Node templating engine. This allows me to have total control over my content and the architecture while being perfectly scalable and easy to maintain.

I also got rid of every social network widget or distraction. I wanted the reading experience to be as immersive as possible, even for the silliest things. I find myself more and more annoyed by distraction on the web, and wanted to work in the direction of cleaningness. If somebody really likes a text, tweeting the link is really not that difficult. And writing resonates with readers if they concentrate on it.

So what's great is that, in addition, Wintersmith supports [Markdown](http://daringfireball.net/projects/markdown/syntax). Markdown is great for a variety of reasons, it's really readable while you write and edit and you can forget about blog plaforms or worrying about CSS once it's live. Furthermore, it's perfect to create articles in a consistent fashion from a regular text editor, which will make it much easier to add writing to my site and have it organize by the date just like a blog platform would do.

Markdown is great because it's intuitive and extremely readable while editing. Instead of tags, you'd use stuff like this:

	Some title
	==========
	A slightly less important title
	-------------------------------

	Paragraphs are separated
	by a blank line.

	Text attributes *italic*,
	**bold**, `monospace`.

	Shopping list:

	  * apples
	  * oranges
	  * pears

	Numbered list:

	  1. apples
	  2. oranges
	  3. pears
