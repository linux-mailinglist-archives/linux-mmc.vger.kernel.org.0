Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC268840
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 13:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfGOLho (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 07:37:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43138 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLho (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2019 07:37:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so12356635oif.10
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2019 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ct0CYM5F6k+ekATcWAW/eEo6/LLNd8N182gpSaiugOE=;
        b=oRSmgHfr0GQ0spP4Y5ldmoreGZRCYUpp5NxP8IQ8y61j/hvR29O/W9rOPUgUzTWbxW
         d468fMZkc1gUW8ng6BA7PVaq0a+rc7fr1vQYNha/xokOlxv+jSDWWzrGF6WuugfrZ2jh
         LNbBFElT0FT5450kLNH72xOy18sjSqqqJ9qwKkx0/+f7HQ1Y7WH1C4DS4GfhraHnkAnO
         QHs81P7kl2najUF3jA61IhfC1tP/HN1DX8mWOKQAiuaY+5lA4cnOiuxhmrvd7+huN89Y
         V2SwrGdey1gMBNTiLTWwHvGJmBmxF19ZqDUwanJtd0Hj02BUUSdpUoq3EWpl9Dp/1ALv
         n0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ct0CYM5F6k+ekATcWAW/eEo6/LLNd8N182gpSaiugOE=;
        b=ponCOyAk8RRbJc1F2Y/806y2b6ZF4+pHBgni2y0cEcvJc+Z60fI4YioImBC6rtqnYw
         dGvqqKvGmGy07V56LxbRfyBVEUV2gyRHr6m0vKLYmSumx2kwOd9bzbQUuQGY1Z6VPfD7
         uciZ4zLn6PBXPK9GLk2zo93z/WOPSjPo/ztH0mN3CGESGEtxqIJJbTV6S68/bi+aEAjT
         RmI+Y6ZWRUzoBWadv7nMfsYjIavCmgHOOhkppAb1jUdaZEqh9mpJI1hiCwnl+zitoy+T
         mGY3WXhAeFMGOUjxuyLx/p53HxRt3ZBWQW+guZniWkIzyhKukco1rvUpRJ7w8aoPd9hl
         4mww==
X-Gm-Message-State: APjAAAWYau45K/r8QJJ0skY69ch7RxZRHLDQRphduZN9ff4FBpEI4+BU
        SbPkJM/AlVfvU9xBrKHXcnOFGLIkT1i1G/bGtDZQiQ==
X-Google-Smtp-Source: APXvYqxZXDcw67zu/CNU8SGUMtg2Wb3YuRzWPOGsUVeptyksgLqQL5UasqRAwcxjuUMUWXBqIg3bFA+zwkgpPDY+vjk=
X-Received: by 2002:aca:6183:: with SMTP id v125mr11830474oib.6.1563190663088;
 Mon, 15 Jul 2019 04:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
 <c54077a4-3aae-c95c-8491-db5f05b0305c@intel.com>
In-Reply-To: <c54077a4-3aae-c95c-8491-db5f05b0305c@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 15 Jul 2019 19:37:31 +0800
Message-ID: <CAMz4kuJVhNFUrDiwiRd-UJ_JnsbxQaV-dE_97m32B+5_53kteg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation
 when runtime resuming
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 15 Jul 2019 at 19:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/07/19 1:58 PM, Baolin Wang wrote:
> > In sdhci_runtime_resume_host() function, we will always do software reset
> > for all, but according to the specification, we should issue reset command
> > and reinitialize the SD/eMMC card.
>
> Where does it say that?

I checked the SD host controller simplified specification Ver4.20, and
in Page 75, Software Reset For All bit, it says "if this bit is set
to1, the host driver should issue reset command and  reinitialize the
SD card". (I did not check other versions).

>
> >                                    However, we only do reinitialize the
> > SD/eMMC card when the SD/eMMC card are power down during runtime suspend.
> >
> > Thus for those platforms that do not power down the SD/eMMC card during
> > runtime suspend, we should not do software reset for all.
> >                                                           To fix this
> > issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
> > to decide if we can do software reset for all or just reset command
> > and data lines.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 9715834..470c5e0 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
> >                       host->ops->enable_dma(host);
> >       }
> >
> > -     sdhci_init(host, 0);
> > +     sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));
>
> We have done a full reset for a long time, so it would be surprising to need
> to change it.
>
> What problem is it causing?

If we did not power down the SD card during runtime suspend, and we
reset for all when runtime resume, our SD host controller can not work
well, will meet some strange behavior, like:

[    6.525397] mmc0: Got data interrupt 0x00000002 even though no data
operation was in progress.
[    6.534189] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    6.540797] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000004
[    6.547413] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
[    6.554029] mmc0: sdhci: Argument:  0x03200101 | Trn mode: 0x00000033
[    6.560645] mmc0: sdhci: Present:   0x01f000f0 | Host ctl: 0x00000030
[    6.567262] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
[    6.573877] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
[    6.580493] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
[    6.587109] mmc0: sdhci: Int enab:  0x037f000b | Sig enab: 0x037f000b
[    6.593726] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[    6.600342] mmc0: sdhci: Caps:      0x1c6d0080 | Caps_1:   0x08000007
[    6.606959] mmc0: sdhci: Cmd:       0x0000061b | Max curr: 0x00ffffff
[    6.613574] mmc0: sdhci: Resp[0]:   0x00001201 | Resp[1]:  0x00000000
[    6.620190] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[    6.626806] mmc0: sdhci: Host ctl2: 0x00003807
[    6.631364] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000df062000
[    6.638697] mmc0: sdhci: ============================================
[    6.645379] mmc0: cache flush error -84

Got data interrupt but no data commands are processing now. With this
patch, then our SD host controller can work well. Did I miss anything
else? Thanks.

-- 
Baolin Wang
Best Regards
