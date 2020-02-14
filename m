Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4E15D720
	for <lists+linux-mmc@lfdr.de>; Fri, 14 Feb 2020 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBNMJE (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 14 Feb 2020 07:09:04 -0500
Received: from foss.arm.com ([217.140.110.172]:60514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgBNMJD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Feb 2020 07:09:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B0C71FB;
        Fri, 14 Feb 2020 04:09:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2ABC3F68F;
        Fri, 14 Feb 2020 04:09:02 -0800 (PST)
Date:   Fri, 14 Feb 2020 12:09:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
Message-ID: <20200214120901.GE4827@sirena.org.uk>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAK8P3a09YDtmOjpBWQEsKd09aotvUW6tOoxUE=CYxh1g8hNW7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline
In-Reply-To: <CAK8P3a09YDtmOjpBWQEsKd09aotvUW6tOoxUE=CYxh1g8hNW7A@mail.gmail.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 10:09:34AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 13, 2020 at 4:43 PM Naresh Kamboju

> > arm beagleboard x15 device failed to boot Linux mainline and
> > linux-next kernel due
> > to below error.
> > This error occurred across all x15 device for these kernel version.

> > This regression started happening on x15 from this commit onwards (27th Jan)
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >   git commit: aae1464f46a2403565f75717438118691d31ccf1
> >   git describe: v5.5-489-gaae1464f46a2

That's Linus' commit:

	Merge tag 'regulator-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> Is it only the merge that introduced the issue, or is the branch that got
> merged already broken?

Or is this just the first commit where the problem happened to be
noticed?  Commits done just before that on the same day include the
dmaengine and MMC merges which seem potentially relevant:

> > [   37.606241] mmc1: Card stuck being busy! mmc_poll_for_busy
> > [   37.611850] mmc1: cache flush error -110
> > [   37.615883] blk_update_request: I/O error, dev mmcblk1, sector
> > 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GjdwACgkQJNaLcl1U
h9AvCAf/dNif51L4NKZ71gq7xDibg/Hu9NUWD7LqMNzduUaeB40Fq+WubJqBcLk+
5mCGCEcLMyx+DcVmO6g1RkyZ2OIRNGbIK7ebZRdOv+iiNo4/L7trEb3nN4Qh6CBo
pWhcjz9EPAqY28y1eYU6l0itlyVFKfPcrNP7iGVqxZoHQgUHUjseRx+jxA60QACD
zfwZ9O2qt9wkc0oTjUb4JMay7mV/C9BxUwEITTsGS8jxt42JZITUHM9vmaLDFGYC
Tnzif/D3K3ohyXE+XeSuuQVXEtb/liTwuBWd5fqJQhpw3/tdzb1T7iDdP0xCvg2/
ZEF3zDb9H8FddbrDCZWgytK6Xa37bg==
=Juis
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--
