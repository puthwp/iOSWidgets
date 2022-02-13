<h1 id="one-design-ios-widgets">One Design iOS UI Element</h1>
Last updated 23 Mar 2021</p>
<h2 id="systems-requirements">Systems Requirements</h2>
<ul>
<li>iOS/ iPadOS version 10 or above</li>
<li>Xcode 11 or above with <strong>Swift Package Manager</strong></li>
</ul>
<blockquote>
<p><code>Use it wisely</code></p>
</blockquote>
<h2 id="installation">Installation</h2>
<p>Follow the instruction of adding Swift Package Manager by using url to <strong>TMB Local Git Repository</strong> <a href="https://bitbucket.tmbbank.local:7990/scm/one/oneapp-ios-widgets.git"> https://bitbucket.tmbbank.local:7990/scm/one/oneapp-ios-widgets.git<br>
</a> than use version <code>0.0.14 - Next Major</code> Follow the step until complete adding package to Project file</p>
<h3 id="dependency">Dependency</h3>
<p><strong>iOS Widgets</strong> comes with 2 dependency below <em>for now</em><br>
<strong>NO NEED TO ADD</strong> to swift package manager</p>
<ul>
<li><strong>SDWebImage</strong> version <code>5.1.0 - Next Major</code> <a href="https://github.com/SDWebImage/SDWebImage.git">link</a></li>
<li><strong>Juanpe/SkeletonView</strong> version <code>1.7.0 - Next Major</code> <a href="https://github.com/Juanpe/SkeletonView.git">link</a></li>
</ul>
<h2 id="components">Components</h2>
<p><strong>iOS Widgets</strong> has been developed to response user’s behaviour by remaining clean but professional. Each of element uses depends on behaviour follow the <strong>TMB One Design Guideline</strong>. Now it has all these elements below</p>
<h3 id="primarybutton">PrimaryButton</h3>
<p>Inherit From UIButton. Remaining the same functionality and APIs</p>
<ul>
<li><strong>PrimaryBigButton</strong>: Big rounded square button with logo on top of the title</li>
<li><strong>PrimaryLargeButton</strong>: The biggest mandatory refreshing orange button always use as the main action of each Views</li>
<li><strong>PrimaryMediumButton</strong>: Same like PrimaryLargeButton smaller size but not the smallest one</li>
<li><strong>PrimarySmallButton</strong>: The smallest button in PrimaryButton series</li>
</ul>
<h4 id="usage">Usage</h4>
<ul>
<li>Drag and Drop UIButton to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UIButton Class</li>
<li>Change it to <code>PrimaryBigButton</code> <code>PrimaryLargeButton</code> <code>PrimaryMediumButton</code> or <code>PrimarySmallButton</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>DONE!<br>
**Also can create programmatically in Code same as UIButton but beware of constraints of width and heigh</li>
</ul>
<h3 id="secondarybutton">SecondaryButton</h3>
<p>Inherit From UIButton. Remaining the same functionality and APIs</p>
<ul>
<li><strong>SecondaryLargeButton</strong>: The biggest secondary button always use as the second action of each Views</li>
<li><strong>SecondaryMediumButton</strong>: Same like SecondaryLargeButton but comes with image icon on the left/ right side of title <em><strong>not yet support</strong></em></li>
<li><strong>SecondarySmallButton</strong>: The smallest button in SecondaryButton series comes with Image icon same as SecondaryMediumButton</li>
</ul>
<h4 id="usage-1">Usage</h4>
<ul>
<li>Drag and Drop UIButton to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UIButton Class</li>
<li>Change it to <code>SecondaryLargeButton</code> <code>SecondaryMediumButton</code> or <code>SecondarySmallButton</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>DONE!<br>
**Also can create programmatically in Code same as UIButton but beware of constraints of width and heigh</li>
</ul>
<h3 id="ghostbutton">GhostButton</h3>
<p>Inherit From UIButton. Remaining the same functionality and APIs but comes with <strong>Dark Mode!</strong></p>
<ul>
<li><strong>GhostLargeButton</strong>: The biggest button with rounded border without background color</li>
<li><strong>GhostMediumButton</strong>: Same like GhostLargeButton but comes with image icon on the left/ right side of title <em><strong>not yet support</strong></em></li>
<li><strong>GhostSmallButton</strong>: The smallest button in GhostButton series comes with Image icon same as SecondaryMediumButton</li>
</ul>
<h4 id="usage-2">Usage</h4>
<ul>
<li>Drag and Drop UIButton to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UIButton Class</li>
<li>Change it to <code>SecondaryLargeButton</code> <code>SecondaryMediumButton</code> or <code>SecondarySmallButton</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>DONE!</li>
<li>Can select <strong>Dark Mode</strong> from Interface builder or set it via Variable<br>
**Also can create programmatically in Code same as UIButton but beware of constraints of width and heigh<br>
**Dark Mode always use with the hight color density background like Black , Grey or Navy</li>
</ul>
<h3 id="primarypillscategory">PrimaryPillsCategory</h3>
<p>Series of rounded button support only one selection with horizontal scrollable view. Easy to use <em>Inherit from UIView</em></p>
<h4 id="conforms-primarypillcategorysourceprotocol-by">Conforms <code>PrimaryPillCategorySourceProtocol</code> by</h4>
<pre class=" language-swift"><code class="prism  language-swift">	<span class="token keyword">func</span> <span class="token function">createPill</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">)</span> <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span class="token builtin">String</span><span class="token punctuation">]</span><span class="token operator">?</span>
	<span class="token keyword">func</span> <span class="token function">sizeForItem</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> at index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span> <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token builtin">CGSize</span><span class="token operator">?</span>
	<span class="token keyword">func</span> <span class="token function">didSelected</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> item<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token punctuation">,</span> index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span>
	<span class="token keyword">func</span> <span class="token function">didDeselected</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> item<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token punctuation">,</span> index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span>
</code></pre>
<h4 id="usage-3">Usage</h4>
<ul>
<li>Drag and Drop UIView to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UIButton Class</li>
<li>Change it to <code>SecondaryLargeButton</code> <code>SecondaryMediumButton</code> or <code>SecondarySmallButton</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>Link element to ViewController and don’t forget to</li>
</ul>
<pre class=" language-swift"><code class="prism  language-swift">    <span class="token keyword">import</span> iOSWidgets
</code></pre>
<ul>
<li>set <code>source</code> variable like this</li>
</ul>
<pre class=" language-swift"><code class="prism  language-swift">    pillsSelection<span class="token punctuation">.</span>source <span class="token operator">=</span> <span class="token keyword">self</span>
</code></pre>
<ul>
<li>than make View Controller conform <code>PrimaryPillCategorySourceProtocol</code> by <code>extension</code> like this</li>
</ul>
<pre class=" language-swift"><code class="prism  language-swift"><span class="token keyword">extension</span> <span class="token builtin">OwnTransferViewController</span><span class="token punctuation">:</span> <span class="token builtin">PrimaryPillCategorySourceProtocol</span> <span class="token punctuation">{</span>
	<span class="token keyword">func</span> <span class="token function">createPill</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">)</span> <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token punctuation">[</span><span class="token builtin">String</span><span class="token punctuation">]</span><span class="token operator">?</span> <span class="token punctuation">{</span>
		<span class="token keyword">return</span>  <span class="token punctuation">[</span><span class="token builtin">Array</span> <span class="token builtin">Of</span> <span class="token builtin">String</span> <span class="token builtin">Items</span><span class="token punctuation">]</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">func</span> <span class="token function">sizeForItem</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> at index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span> <span class="token operator">-</span><span class="token operator">&gt;</span> <span class="token builtin">CGSize</span><span class="token operator">?</span> <span class="token punctuation">{</span>
		<span class="token punctuation">[</span><span class="token builtin">Size</span> <span class="token keyword">for</span> each items<span class="token punctuation">,</span> <span class="token keyword">return</span> <span class="token constant">nil</span> to <span class="token keyword">dynamic</span> width 30px height<span class="token punctuation">]</span>
		<span class="token keyword">return</span> <span class="token function">CGSize</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">?</span><span class="token operator">?</span> <span class="token constant">nil</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">func</span> <span class="token function">didSelected</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> item<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token punctuation">,</span> index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
		<span class="token comment">///Do something</span>
	<span class="token punctuation">}</span>
	<span class="token keyword">func</span> <span class="token function">didDeselected</span><span class="token punctuation">(</span>source<span class="token punctuation">:</span> <span class="token builtin">Pills</span><span class="token punctuation">,</span> item<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token punctuation">,</span> index<span class="token punctuation">:</span> <span class="token builtin">Int</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
		<span class="token comment">///Do something</span>
	<span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<ul>
<li>You can customize the button font and item spacing by set these value</li>
</ul>
<pre class=" language-swift"><code class="prism  language-swift">	pillsSelection<span class="token punctuation">.</span>font <span class="token operator">=</span> <span class="token builtin">UIFont</span><span class="token punctuation">.</span>system
	pillsSelection<span class="token punctuation">.</span>spacing <span class="token operator">=</span> <span class="token number">8.0</span>
	pillsSelection<span class="token punctuation">.</span>deselectable <span class="token operator">=</span> <span class="token boolean">true</span>
</code></pre>
<h3 id="primarytextfield">PrimaryTextField</h3>
<p><em>Inherit From UITextField</em>. Remaining the same functionality and APIs but comes with <strong>theses!</strong>  ps. support only single line</p>
<ul>
<li><strong>icon image</strong>: set by <code>.icon: UIImage</code></li>
<li><strong>folding Title</strong>: set by <code>.title = "Input Here"</code></li>
<li><strong>action item</strong>: with <code>.action() closure</code></li>
<li><strong>helping text with icon</strong>: The smallest button in GhostButton series comes with Image icon same as SecondaryMediumButton</li>
<li><strong>error</strong>: support error by throw in the error that conforms <code>PrimaryError</code></li>
<li><strong>counting label</strong>: <em>not yet support</em></li>
</ul>
<h4 id="usage-4">Usage</h4>
<ul>
<li>Drag and Drop UIButton to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UITextField Class</li>
<li>Change it to <code>PrimaryTextField</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>Set and Design TextField’s attribute including the list above through Xcode Interface Builder</li>
<li>DONE!</li>
</ul>
<p>**Also can create programmatically in Code same as UITextField but beware of constraints of width and heigh</p>
<h4 id="error-handling">Error Handling</h4>
<p>Create struct, class or enum that conforms <code>PrimaryError</code> like this</p>
<pre class=" language-swift"><code class="prism  language-swift">	protocol <span class="token builtin">PrimaryError</span><span class="token punctuation">:</span> <span class="token builtin">Error</span> <span class="token punctuation">{</span>
		<span class="token keyword">var</span> description<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token operator">?</span> <span class="token punctuation">{</span> <span class="token keyword">get</span><span class="token punctuation">}</span>
	<span class="token punctuation">}</span>
</code></pre>
<p>create Enum to conforms above by</p>
<pre class=" language-swift"><code class="prism  language-swift">	<span class="token keyword">enum</span> <span class="token builtin">TransferValidationError</span><span class="token punctuation">:</span> <span class="token builtin">PrimaryError</span> <span class="token punctuation">{</span>
	    <span class="token keyword">case</span> amountIsNeeded
	    <span class="token keyword">case</span> insufficientAmount
	    <span class="token keyword">case</span> needToAccount
	    <span class="token keyword">case</span> noteIsTooLonge
	    
	    <span class="token keyword">var</span> description<span class="token punctuation">:</span> <span class="token builtin">String</span><span class="token operator">?</span> <span class="token punctuation">{</span>
	        <span class="token keyword">switch</span> <span class="token keyword">self</span> <span class="token punctuation">{</span>
	        <span class="token keyword">case</span> <span class="token punctuation">.</span>amountIsNeeded<span class="token punctuation">:</span>
	            <span class="token keyword">return</span> <span class="token string">"Please enter an amount."</span>
	        <span class="token keyword">case</span> <span class="token punctuation">.</span>insufficientAmount<span class="token punctuation">:</span>
	            <span class="token keyword">return</span> <span class="token string">"Your account has insufficient funds for this transaction."</span>
	        <span class="token keyword">case</span> <span class="token punctuation">.</span>needToAccount<span class="token punctuation">:</span>
	            <span class="token keyword">return</span> <span class="token string">"Please select destination account"</span>
	        <span class="token keyword">case</span> <span class="token punctuation">.</span>noteIsTooLonge<span class="token punctuation">:</span>
	            <span class="token keyword">return</span> <span class="token string">"Note is too long"</span>
	        <span class="token punctuation">}</span>
	    <span class="token punctuation">}</span>
	<span class="token punctuation">}</span>
</code></pre>
<p>That’s it! Now you’re ready…</p>
<h3 id="primaytextview">PrimayTextView</h3>
<p><em>Inherit From UITextView</em> with the design but Remaining the same functionality and APIs. Support multiple lines with no scrollview but <strong>EXTEND THE HEIGHT!</strong> and last but not least also support <strong>PLACEHOLDERrrrrr</strong></p>
<ul>
<li><strong>icon image</strong>: set by <code>.icon: UIImage</code></li>
<li><strong>folding Title</strong>: set by <code>.title = "Input Here"</code></li>
<li><strong>placeholder</strong>: set by <code>.placeholder = "This is optional"</code></li>
<li><strong>action item</strong>: with <code>.action() closure</code></li>
<li><strong>helping text with icon</strong>: The smallest button in GhostButton series comes with Image icon same as SecondaryMediumButton <em>buggy</em></li>
<li><strong>error</strong>: support error by throw in the error that conforms <code>PrimaryError</code> same as PrimaryTextFields</li>
<li><strong>counting label</strong>: <em>not yet support</em></li>
</ul>
<h4 id="usage-5">Usage</h4>
<ul>
<li>Drag and Drop UIButton to the UIView than adjust width and height</li>
<li>Go to <strong>Custom Class</strong> side view to Override UITextView Class</li>
<li>Change it to <code>PrimaryTextView</code></li>
<li>Change <strong>Module</strong> to <code>iOSWidgets</code></li>
<li>Set and Design TextField’s attribute including the list above through Xcode Interface Builder</li>
<li>DONE!</li>
</ul>
<p>**Also can create programmatically in Code same as UITextView but beware of constraints of width and heigh</p>
<p>ps. <code>PrimaryTextFields</code> and <code>PrimaryTextView</code> have the same mother</p>
<h3 id="accountcardsview">AccountCardsView</h3>
<h3 id="loadablenib">LoadableNib</h3>
<h3 id="ttbbasedesign">TTBBaseDesign</h3>
<p><strong>TTBBaseBlueDesign</strong><br>
<strong>TTBBaseWhiteDesign</strong></p>

