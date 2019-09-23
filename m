Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3EBBE0C
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502982AbfIWVj1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 17:39:27 -0400
Received: from esa01.kjsl.com ([198.137.202.87]:17090 "EHLO esa01.kjsl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390047AbfIWVj1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Sep 2019 17:39:27 -0400
Received: from unknown (HELO people.danlj.org) ([IPv6:2607:7c80:54:5:7609:68e3:940d:b47c])
  by esa01.kjsl.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 21:39:26 +0000
Received: from people.danlj.org (localhost [127.0.0.1])
        by people.danlj.org (8.14.7/8.14.7) with ESMTP id x8NLdQ2x019291
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Sep 2019 17:39:26 -0400
Received: (from johnsonm@localhost)
        by people.danlj.org (8.14.7/8.15.2/Submit) id x8NLdPTQ019290;
        Mon, 23 Sep 2019 17:39:25 -0400
Date:   Mon, 23 Sep 2019 17:39:25 -0400
From:   "Michael K. Johnson" <johnsonm@danlj.org>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Message-ID: <20190923213925.GA19247@people.danlj.org>
References: <cover.1568184581.git.benchuanggli@gmail.com>
 <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org>
 <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 18, 2019 at 02:07:51PM +0300, Adrian Hunter wrote:
> On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > I see that the first four patches made it into Linus's kernel
> > yesterday. Is there any chance of this final patch that actually
> > enables the hardware making it into another pull request still
> > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > addressing all the review comments?
...
> > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> Add support for the GL9750 and GL9755 chipsets.
> >>
> >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> >> tuning flow for GL9750.
> > 
> 
> It is OK by me:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Ulf,

Sorry to be a bother... Is anything remaining for this work to make
it into a second PR for 5.4 before the merge window closes?

It would be really convenient for the microsd readers in
current-generation thinkpads (for instance) to have hardware support out
of the box without having to wait another kernel release cycle, if
there's nothing otherwise remaining to change.  I confirmed that
it currently applies cleanly on top of Linus's kernel.

Thanks
