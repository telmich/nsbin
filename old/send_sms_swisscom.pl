#!/usr/bin/perl -w
#
# (c) 2007, Tonnerre Lombard <tonnerre@pauli.sygroup.ch>,
#	    SyGroup GmbH Reinach. All rights reserved.
#
# Redistribution and use  in source and binary forms,  with or without
# modification, are  permitted provided that  the following conditions
# are met:
#
# * Redistributions  of source  code must  retain the  above copyright
#   notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form  must reproduce the above copyright
#   notice, this  list of conditions  and the following  disclaimer in
#   the  documentation  and/or   other  materials  provided  with  the
#   distribution.
# * Neither  the  name  of  the  SyGroup  GmbH nor  the  name  of  its
#   contributors may  be used to  endorse or promote  products derived
#   from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED  BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A  PARTICULAR PURPOSE ARE DISCLAIMED. IN  NO EVENT SHALL
# THE  COPYRIGHT  OWNER OR  CONTRIBUTORS  BE  LIABLE  FOR ANY  DIRECT,
# INDIRECT, INCIDENTAL,  SPECIAL, EXEMPLARY, OR  CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT  NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE GOODS OR
# SERVICES; LOSS  OF USE, DATA, OR PROFITS;  OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY  THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT  LIABILITY,  OR  TORT  (INCLUDING  NEGLIGENCE  OR  OTHERWISE)
# ARISING IN ANY WAY OUT OF  THE USE OF THIS SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
#

use LWP::UserAgent;

if ($#ARGV != 1) {
   die("$0: number text");
}
my $number  = $ARGV[0];
my $text    = $ARGV[1];

my $ua = new LWP::UserAgent;
$ua->timeout(10);
$ua->env_proxy();
$ua->cookie_jar({});

$response = $ua->post('https://www.swisscom-mobile.ch/youth/sms_senden-de.aspx?login',
{
	isiwebuserid =>	'your-phone-number-here',
	isiwebpasswd =>	'your-web-password-here'
});
unless ($response->is_success() || $response->is_redirect())
{
	die('Unable to log into SMS gateway: ' . $response->status_line());
}
$response = $ua->post('https://www.swisscom-mobile.ch/youth/sms_senden-de.aspx',
{
	'__EVENTTARGET' =>			'',
	'__EVENTARGUMENT' =>			'',
	'__VIEWSTATE_SCM' =>			'1',
	'__VIEWSTATE' =>			'',
	'FooterControl:hidNavigationName' =>	'SMS senden',
	'FooterControl:hidMailToFriendUrl' =>	'youth/sms_senden-de.aspx',
	'CobYouthSMSSenden:txtNewReceiver' =>	"$number",
	'CobYouthSMSSenden:txtMessage' =>	"$text",
	'CobYouthSMSSenden:btnSend' =>		'Senden'
});
unless ($response->is_success())
{
	die('Unable to send SMS: ' . $response->status_line());
}
$response = $ua->get('https://www.swisscom-mobile.ch/youth/youth_zone_home-de.aspx?logout');
unless ($response->is_success())
{
	warn('Unable to log out of SMS gateway: ' . $response->status_line());
}

exit(0);
