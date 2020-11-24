Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE9A2C29C9
	for <lists+linux-mmc@lfdr.de>; Tue, 24 Nov 2020 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgKXOgn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 24 Nov 2020 09:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgKXOgm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 09:36:42 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F44206E5;
        Tue, 24 Nov 2020 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228602;
        bh=B2MlKFsceXQr71C4amqrr6Fj7QFEXJ4fA9TlTP79EgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1gN2f1RCX7iirVk5oDP5rBg/0v3uuMaQFpVkDxmwqo1r7qBWSA1nBdHtuwagQz9OI
         81XTJe8jzGwbEK92wAYPj+3EfPQ5P/USb2eJbhkYZ758IwPOGN22k84s3iIjN44ikN
         8kiUG9Js6BiwjS36TWtLiNSp1Pyzzo6CiLI9rVr0=
Date:   Tue, 24 Nov 2020 08:36:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 098/141] mmc: sdhci-of-arasan: Fix fall-through warnings
 for Clang
Message-ID: <20201124143657.GE16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
 <CAPDyKFpkQBzryACA3et_RGk2hcMUK=j_fiycykdjCNfur6h45g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpkQBzryACA3et_RGk2hcMUK=j_fiycykdjCNfur6h45g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Nov 24, 2020 at 03:25:32PM +0100, Ulf Hansson wrote:
> On Fri, 20 Nov 2020 at 19:37, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of
> > letting the code fall through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied for next, thanks!

Thank you, Uffe.
--
Gustavo
