---
title: Trainfuck
author: franc
date: 2014-10-22
template: project.jade
---

Brainfuck is an esoteric programming language, used mostly for challenges and programming language design athletics. It is very minimalist, and superconfusing. Here's 'Hello World!' in Brainfuck.

```
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.
```

A Brainfuck program has an implicit byte pointer, free to move within array of 30k bytes, initially all set to 0. The language has a set of 8 commands, represented by the following characters.

```
> 	Increment the pointer.
< 	Decrement the pointer.
+ 	Increment the byte at the pointer.
- 	Decrement the byte at the pointer.
. 	Output the byte at the pointer.
, 	Input a byte and store it in the byte at the pointer.
[ 	Jump forward past the matching ] if the byte at the pointer is zero.
] 	Jump backward to the matching [ unless the byte at the pointer is zero.
```

### A Manhattan-bound Trainfuck is approaching the station

Trainfuck is an implementation of Brainfuck using the MTA subway system. I'm looking for ways of implementing the language in a way that can be literally compiled and interpreted, but in the meantime I'm just setting the rules for some real world fun.

In reality, it's a different encoding of the Brainfuck commands. 


```
<	Move one station forward
>	Change directions, move one station backwards
+	Take a selfie with a stranger with the name of the station behind you two
-	Take a selfie by yourself with the name of the station behind you
[	Go out using the turning pole, come back in using the spinning door
] 	Go out using the spinning door, come back in using the turning pole
.	Say out loud the value in the cell, with the name of the station behind you
,	Undefined for now
```

With this set of rules, I've started on 14th Street on the A line and followed the rules to print 'Hello World' as a proof of concept. 