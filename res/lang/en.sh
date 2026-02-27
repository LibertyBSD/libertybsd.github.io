#!/bin/sh


# index
# --------------------------------------
title_index="LibertyBSD"

index_raddle="/f/libertybsd on <a href='https://raddle.me'>raddle</a> &#x1f44d;"
index_reddit="/r/libertybsd on <a href='https://reddit.com'>reddit</a> &#x1f44e;"
index_freenode="#libertybsd on <a href='https://freenode.net'>Freenode</a> &#x2605;"


index_p1="<a href='https://openbsd.org'>OpenBSD</a> is universally known as an operating
system designed with security in mind, proudly being able to say that it has had
&ldquo;Only two remote holes in the default install, in a heck of a long time!&rdquo;"

index_p2="However, OpenBSD ships with
<a href='https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/sys/dev/microcode'>several pieces of
non-free, binary only firmware</a> in the base system, and depending on the hardware
detected, by default
<a href='https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/distrib/miniroot/install.sub.diff?r1=1.653&r2=1.654&f=h'>
a script will download more at first boot</a>, without informing the user."

index_p3="While there may be some good reasons for including this firmware, with a
default installation you might end up running some of these non-free blobs without even
knowing it."

index_p4="LibertyBSD is a 'deblobbed' version of OpenBSD. The non-free blobs in OpenBSD
have been purged from LibertyBSD, so you can enjoy the benefits of OpenBSD without
sacrificing your freedom."


# downloads
# ---------------------------------------
title_download="LBSD - Downloads"
download_downloads="Downloads"

download_host="Host"
download_type="Type"
download_location="Location"
download_protocols="Protocols"
download_current_mirrors="Current Mirrors"
download_old_mirrors="Old Mirrors"
download_last_version="Last Version"
download_full="Full"
download_install_only="Install-only"
download_defunct_mirrors="Defunct Mirrors"
download_defunct_mirrors_info="These are sites that once mirrored LibertyBSD,
but don't anymore for one reason or another."


location_chiba_japan="Chiba, Japan"
location_usa="USA"
location_texas_usa="Texas, USA"


# FAQ
# --------------------------------------
title_faq="LBSD - FAQs"
faq_faq="Frequently Asked Questions"

faq_qarch="What architectures does LBSD support?"
faq_aarch="Since 5.9, both <code>amd64</code> and <code>i386</code> are
supported."
faq_qfsf="Is LibertyBSD FSF-approved?"
faq_afsf="We're going through the process to be approved as FSDG-compliant."
faq_qerrata="So, what about security updates…?"
faq_aerrata="You can find patches <a href='errata.shtml'>here</a>.
You can manually compile and apply the patches yourself, if you want.<br />
Or you could use <code>syspatch</code>. Whatever floats your boat."
faq_qman="Where are the man-pages?"
faq_aman="In 5.6, man-pages were excluded-- but since then, they've been
included by default. We've added on to them, even!
<code>free-software(7)</code> and <code>fsdg(7)</code>, specifically."
faq_qcontact="Where can I contact you, or get some help?"
faq_acontact="You can write to
<a href='https://raddle.me/f/libertybsd'>/f/libertybsd</a> at raddle.me
(you're certain to get a response there), the #libertybsd IRC channel at
irc.freenode.net (almost certain to get a response, if a tad delayed), or
<a href='https://reddit.com/r/libertybsd'>/r/libertybsd</a> at reddit.com
(unlikely to get a response there).<br>
If it's a more private matter, you can e-mail Jaidyn &lt;jadedctrl AT teknik.io&gt;."
faq_qsources="Cool, whatever. Where's the sauce, mate?"
faq_asources="You can find the patched source-code in your local FTP/HTTP
mirror under 'src.tar.gz', 'sys.tar.gz', and 'xenocara.tar.gz'. If you want
the scripts used to patch it, you'll find those over at
<a href='https://git.eunichx.us/libertybsd-scripts'>the git repo</a>."
faq_qnonfree="Aha! I've found something non-free in LibertyBSD!"
faq_anonfree="Impressive eyes you've got there!
<a href='faq.shtml#contact'>Contact us</a> right away, please!
(According to me, you deserve a GNU buck. ;))"
faq_qproblems="I have a problem with LBSD. Can I use the OpenBSD mailing list?"
faq_aproblems="You really shouldn't! LibertyBSD might be a simple downstream,
but it <i>does</i> have modifications-- so you shouldn't report bugs unless
replicated in OpenBSD, or ask for help. Don't bother them, please! Instead,
bother us. We'll help you the best we can. ;)"
faq_qports="Where's the ports tree? Package repo?"
faq_aports="They're in your mirror's directory for your version-- under
'packages' for the repo, and 'ports.tar.gz' for the ports tree. (The ports
tree and repo are pure and squeaky-clean, by the way~)"



# --------------------------------------
# ---------------------------------------
# header
header_index="Index"
header_download="Downloads"
header_faqs="FAQs"
header_install="Install Guide"
header_git="Git"


# ---------------------------------------
# footer
footer_license="The HTML & CSS used to generate this webpage is hereby released
into the public domain. This applies worldwide. In case this is not legally
possible, any entity is granted the right to use this work for any purpose,
without any conditions, unless such conditions are required by law."
