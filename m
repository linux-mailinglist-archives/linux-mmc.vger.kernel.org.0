Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9D9DACD
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfH0ArO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 26 Aug 2019 20:47:14 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49223 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbfH0ArO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Aug 2019 20:47:14 -0400
X-IronPort-AV: E=Sophos;i="5.64,435,1559512800"; 
   d="scan'208";a="398956385"
Received: from unknown (HELO hadrien) ([183.173.92.181])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:47:08 +0200
Date:   Tue, 27 Aug 2019 08:47:04 +0800 (CST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Andrew Jeffery <andrew@aj.id.au>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
In-Reply-To: <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
Message-ID: <alpine.DEB.2.21.1908270845410.2537@hadrien>
References: <20190826120013.183435-1-weiyongjun1@huawei.com> <20190826130343.GA23584@kadam> <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On Tue, 27 Aug 2019, Andrew Jeffery wrote:

>
>
> On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
> >                         ^^^^
> > When we're adding new files, could we use the prefix for the new driver
> > instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> > Otherwise it's tricky to know what people want for the driver.
>
> I don't have any issue with the request, but I don't understand this last
> bit. What do you mean by "it's tricky to know what people want for the
> driver"?

There is no obvious algorithm that tells how to go from a file name to an
appropriate subject line prefix.

julia
