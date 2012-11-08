Features
========

Presently, SecurityInterface has a whopping one class: `KSPasswordField`. It:

* Shows the password in plain text on-demand
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

Licensed under the BSD License <http://www.opensource.org/licenses/bsd-license>
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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