---
title: A few notes on modular Javascript
author: franc
date: 2014-02-02
template: article.jade
---

So when you start writing your first large applications, all the material and documentation you will find will tell you to write *modular* code, that is, use the module pattern for absolutely everything. This, they say, will give you great control over private and public methods without polluting the global namespace.

Which is totally true and something that understanding early in the process will save you a lot of refactoring time and debugging nightmares.

However, it's not immediately obvious to a person who's learning to code how the structure needs to be layed out.

Here's a module:

```javascript
var MODULE = (function (myModule) {
	var _variable = 45;

	myModule.getVariable = function () {
		return _variable;
	}

	return myModule;

}(myModule || {}));
```

This is a module with one very clear function, make a non-public variable within the module accessible outside the [closure](http://javascriptissexy.com/understand-javascript-closures-with-ease/). 

For convention, I noted the variable as private by using an leading underscore '_'.

Now, when you're dealing with a site that is likely to need more than a handful of lines and likely to lean towards OOP as much as Javascript can get, dividing functionality in modules should be done from the start, no matter whether you're using a third-party framework or creating your own.

In order to organize your code while you're writing, the best you can do is to have every module in a different file, and use something like [RequireJS](http://www.requirejs.org) to orderly load them.

Here's a list of the best articles I've found to understand how to organize and properly write modular code:

* [Preparing yourself for modern JS development](http://www.codethinked.com/preparing-yourself-for-modern-javascript-development), by Justin Etheredge (__Make sure to start here!__).
* [Common JS gotchas](http://www.jblotus.com/2013/01/13/common-javascript-gotchas/), by James Fuller
* [Javascript Module Pattern in depth](http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html) (The most complete and "aha"-inducing article ever to be written about JS), by Ben cherry.