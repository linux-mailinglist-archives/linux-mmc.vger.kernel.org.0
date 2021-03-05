Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB58632F693
	for <lists+linux-mmc@lfdr.de>; Sat,  6 Mar 2021 00:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEXZI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 5 Mar 2021 18:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEXYk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Mar 2021 18:24:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782726509F;
        Fri,  5 Mar 2021 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614986679;
        bh=rjrdBvvuom4CkMuw2NngQyMnEWdbvqp06pyi4QsAwdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3yYB3icU3iMc6k/NqeEDP1VNRgDUu00PsxiM+U32Qib/nz6/G1CJG31sJUK2vZ2o
         BL67RlJT+ZyCE8Iv60gFnPKGZ+4a+0c8XOf3CHingswAXn57tifatB8Fk+UPsFC6Gj
         Bfu4e+VsW1wP6MfjzU1G8k6uMNvLaYznAjw0TqkAdTbuQ0V0Yrz46mVUW/cHCZFO6N
         NgjNX4UJBUD5bFfVeHDYvf/ncxUUXGiD/ggnUHxw1u1eRDDyMaqvU/JFn3aEuk1oqz
         //0I9EqTea5vWOphFgooiQWxeac3xWH/IPMypJTTClszKU7z8wCqL4m2AnQmb3timr
         RO+4Zta47s8cQ==
Date:   Fri, 5 Mar 2021 15:24:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Peng.Zhou" <peng.zhou@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Satya Tangirala <satyat@google.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>
Subject: Re: [PATCH 1/4] mmc: mediatek: add Inline Crypto Engine support
Message-ID: <YEK9tXrOB2yQlqCl@gmail.com>
References: <20210302024557.4868-1-peng.zhou@mediatek.com>
 <YD3OFkjS8a6EUOHM@google.com>
 <CAPDyKFp9Uu69i7_0rDm2=c26GCagkjyuzp=avdVd2RcpoC2ZYA@mail.gmail.com>
 <1614947486.11643.4.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614947486.11643.4.camel@mbjsdccf07>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Mar 05, 2021 at 08:31:26PM +0800, Peng.Zhou wrote:
> > > Somehow I can't apply this patch using git am. It looks like the mail
> > > isn't completely plain text (there's some html it seems), which may be
> > > why git am is complaining.
> > 
> > I assume this is why patchwork didn't accept them. Please re-post in
> > plain/text and use "git send-email".
> > 
> > Kind regards
> > Uffe
> 
> I'm sorry about that, but I had used "git send-email" for above, and I
> had used checkpatch.pl to check but I don't find anything which will
> result in this error, I will check it much more...
> 

Same problem with your v2 patches.  Also I only received 2 of the 4 patches, and
none of them were received by the mailing list
(https://lkml.kernel.org/linux-mmc/).
Are you using something like 'git format-patch --cover-letter @~4..@'
and 'git send-email *.patch --to=... --cc=...'?
Otherwise, it might be a problem with the mail server you're using.

- Eric
