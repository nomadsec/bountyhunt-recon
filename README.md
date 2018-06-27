# bountyhunt-recon
* aquatone
* sublist3r
* merge them
* tko-subs
* crlf check
* ~~+https~~
* ~~masscan~~
* onetwopunch
  * unicornscan
  * nmap on unicornscan findings
* jboss
* dirsearch

## bash script for opening salvo of (web) recon

This is a small part of the overall recon process, but a nice time-saver.

Don't run this unless you know what each tool does and you have read the terms or scope of your target - modify it accordingly. i.e. is brute forcing directories allowed?

I use this script when I first start recon on a new bug bounty program. I might try to come back to this and explain when to use it, when to modify it, etc. But if you read the docs for each tool or know them already it's probably fairly self-explanatory. It's nice to let this run and free you up to do more manual recon/osint

tko-subs has --takeover flag off by default. Might I suggest you leave it off. automating takeovers might lead you out of scope - again, read the program details before running this and modify options accordingly. If you find a sub vulnerable to hijacking just manually do it. aquatone will screenshot for you and tko-subs will list the domain and the bad return fingerprint.

happy hacking :)


### dependencies

  * your own api keys
  * the tools listed above
  * the requirements that you come across installing the tools
  
### some random requirements that might not be evident or automated while installing tools
  * node.js
  * npm
  * ruby
  * argparse
  * dnspython
  * requests (use pip)
  * golang
