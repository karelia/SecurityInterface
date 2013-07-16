Features
========

Presently, SecurityInterface has a whopping one class: `KSPasswordField`. It:

* Shows the password in plain text on-demand
* On the basis that password visibility is likely being toggled for editing, makes the field the first responder
* Automatically cleans up likely unwanted whitespace when pasting or dragging in passwords

Contact
=======

I'm Mike Abdullah, of [Karelia Software](http://karelia.com). [@mikeabdullah](http://twitter.com/mikeabdullah) on Twitter.

Questions about the code should be left as issues at https://github.com/karelia/SecurityInterface or message me on Twitter.

Dependencies
============

None beyond AppKit. Probably works back to OS X v10.2 if you were so inclined

License
=======

Copyright © 2012 Karelia Software

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Usage
=====

1. Add `KSPasswordField.h` and `KSPasswordField.m` to your project. Ideally, make this repo a submodule, but hey, it's your codebase, do whatever you feel like.
2. In Interface Builder, create a regular `NSSecureTextField` and then set its custom class to be `KSPasswordField`. You can also instantiate `KSPasswordField` directly like any other control
3. Whitespace-cleanup comes for free; no extra work required
4. To control showing the password, `KSPasswordField` has the following methods:
	* `@property(nonatomic) BOOL showsText;`
	* `- (IBAction)showText:(id)sender;`
	* `- (IBAction)secureText:(id)sender;`
	* `- (IBAction)toggleTextShown:(id)sender;`

I generally prefer to hook up a checkbox (`NSButton`) straight to the `toggleTextShown:` action