Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEAA251816
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Aug 2020 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgHYMB7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 25 Aug 2020 08:01:59 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:61528 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgHYMBB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 08:01:01 -0400
IronPort-SDR: 6zdHpv3OdfV3hyh0EdskEu+UPLu/M69ZmFtzQKXZ1pCrVeU7JOR82StliBN4baJEAea/bJSd+5
 F/2twTHqOfoeNmGl+BrodQTF2fpEriSycrhp/VM0Mgo5LKwRHCEPi55A1V6J4yL9M0+OpRkpq9
 ulam5l+pqQpnHw9qrVop951qwBhIcSZZAA4pSQ9koMnuv6ht8UTmCPSnhCcwW+1yf73ZDsmYbM
 /0BvNI895j9fSvmD6y1EgnrG5lZ9Zi6pmz0G5FVvtBTkbvpwZ74jRDwLo9Zp8LRfb3hsWSn2rL
 qE8=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13590046"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 25 Aug 2020 14:00:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 25 Aug 2020 14:00:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 25 Aug 2020 14:00:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598356840; x=1629892840;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8miJjHVFYc/bpyj6qBdQOmlSnWEp1x28yyZ2xAwXd7E=;
  b=TFpFgGIItZZ6Hfm9j+DSHG8urROrM04d6sXbAaGI11CpJC+CGjRuY2FN
   FVhKNCK9vRyd3ipqGaNKnvFPiYuBQwMQ/OEcgLhyUoojyLmkDCM6I+Psp
   pHxSg7PYV9L7xPqSZUDCj06dOiSkOZu9OIOw67XJdu0+J+cP/VNp9iDlF
   gyepLv9uKgaXiwg+iTl94HOO6Gt4c7Jsnkt9ql7YllOnZ48BIwTYLChQO
   8Z78wvHiRWCDDS7mWU0HsIk0LflJhbMsH3lWU1xOuoqG/oi8Xkw7b1UIC
   Zs1+0PDC3jH+A1vW12qtYk+wJJ/E9LWOPij++EoBpQxd2YOPPn7X3kJgX
   g==;
IronPort-SDR: 3ZUPXeoIoG8BMineYbSaOq103KqArpYZptsK7J8L/+d6BXHFTn08diiop2JaQ/kg+DYBuAIV0n
 vTV+IwTJoidgr6baurJmZgR3v4PEjLWIf9Z+Er3215Zmc3NRRywTQrnVDRoAN2loUfVBNztZLt
 bMBkmgdmjJTEQXQsCol1+JPuA10WP/tj9bomARTk5jINV5YdULrMfWQpOK/r56z5HIwSprcusO
 oCmsqYusVbOzIsgyuf+DpewTRRCw5/l/nbGmRTtXiYSPxkYLK7QHeZHkHJZ1hhfsLzUTVx/q6C
 yRQ=
X-IronPort-AV: E=Sophos;i="5.76,352,1592863200"; 
   d="scan'208";a="13590045"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 25 Aug 2020 14:00:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3DA40280065;
        Tue, 25 Aug 2020 14:00:40 +0200 (CEST)
Message-ID: <11654b05dd8fb87e195aed20cbdaa22d8856b072.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH mmc-next v2] mmc: allow setting slot index via
 device tree alias
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 25 Aug 2020 14:00:38 +0200
In-Reply-To: <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com>
References: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
         <CAPDyKFoi7KghuBqu7YVS4GH4Bp1puhgb=PcwBVDvaTesLujrrw@mail.gmail.com>
         <548605506aa2e73afafdc228263da04585871e0b.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2020-08-25 at 11:39 +0200, Matthias Schiffer wrote:
> On Tue, 2020-08-25 at 11:14 +0200, Ulf Hansson wrote:
> > On Thu, 20 Aug 2020 at 09:59, Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int extra,
> > > struct device *dev)
> > >  {
> > >         int err;
> > >         struct mmc_host *host;
> > > +       int alias_id, min_idx, max_idx;
> > > 
> > >         host = kzalloc(sizeof(struct mmc_host) + extra,
> > > GFP_KERNEL);
> > >         if (!host)
> > > @@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int extra,
> > > struct device *dev)
> > >         /* scanning will be enabled when we're ready */
> > >         host->rescan_disable = 1;
> > > 
> > > -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> > > +       host->parent = dev;
> > > +
> > > +       alias_id = mmc_get_reserved_index(host);
> > > +       if (alias_id >= 0) {
> > > +               min_idx = alias_id;
> > > +               max_idx = alias_id + 1;
> > > +       } else {
> > > +               min_idx = mmc_first_nonreserved_index();
> > > +               max_idx = 0;
> > > +       }
> > > +
> > > +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx,
> > > GFP_KERNEL);


One more question I came across when reworking my patch: Do we need a
fallback here for the case where the reserved index is already taken?
To handle an SD card being replaced while still mounted?


> > >         if (err < 0) {
> > >                 kfree(host);
> > >                 return NULL;
> > > @@ -406,7 +418,6 @@ struct mmc_host *mmc_alloc_host(int extra,
> > > struct device *dev)
> > >         dev_set_name(&host->class_dev, "mmc%d", host->index);
> > >         host->ws = wakeup_source_register(NULL, dev_name(&host-
> > > > class_dev));
> > > 
> > > -       host->parent = dev;
> > >         host->class_dev.parent = dev;
> > >         host->class_dev.class = &mmc_host_class;
> > >         device_initialize(&host->class_dev);
> > > --
> > > 2.17.1
> > > 
> > 
> > Kind regards
> > Uffe

