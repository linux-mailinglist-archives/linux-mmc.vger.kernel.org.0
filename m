Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4200A33D0E
	for <lists+linux-mmc@lfdr.de>; Tue,  4 Jun 2019 04:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFDCSv (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Jun 2019 22:18:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35405 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDCSv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jun 2019 22:18:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id n14so18100659otk.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jun 2019 19:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l+D3rSEai4qzn+TyHSQz7IIWfxK6zl3YHxlBM75Sxk=;
        b=ji0kqvdjzqwIUAMrKo44/NCdPxG7kCOt7Hn0ZEmNeX4IylO3gLu2LJSi/pElY7IIbM
         HN5nagHzCYI8L27LLselXWAYkf6bFKXGIxq2Vctezw/AB8zsC8WOydU92z/XH/2aoK2A
         yh2lvRhAVbV8FPmdWiyypeA6uHZAXIx5pvFi+Ct0Kh7I0FAf64XN2E/BwPIBb0bcHdSX
         0Gta6gcFmqEcmnp9kCfe3nLwyWf+SbQ1Nw+DlL57VPLsJeN/JiL8rhTgp1JmmBtAQZsF
         I1fiAFO0iWTIN38nBkT3M8I9T/Fupjok5DxcRbIXHTx7RIXemRNu1Cdirlm7sqCCiuyq
         CTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l+D3rSEai4qzn+TyHSQz7IIWfxK6zl3YHxlBM75Sxk=;
        b=snw7aeo/ccQgLfV5jKFEYbgecupmaJhGyBTxrRr40oyHOFSgB1AtJDSUYAbDzM2fWs
         DAbYjDCa/rpIOJnL/0W5VSZbyGrjibjJlrgxmRX4qbBVPyUM5HT/kdW74Fcsxn7MuJaD
         /Bkp7gtFPDlvwmzbN8dBX2AQWYHMiFxAVhbyASL8glQnuWsYyE7LjVdus4/46ScBX/8e
         1QzjX/tmYwH4Guf4774RmJi57BXYA/QuRRkrFGZ/IIAm94CIb2QL/YQubRvOD4KYdv38
         1ibO42bN0HSSBoPxOdNWYeVUkz+KbvDMwbLwRQWyMd9noyfijp6OAJPZPVS9w7mQAVIY
         CJrg==
X-Gm-Message-State: APjAAAU5a8mswsFrwvlbVt+9qpWrhl+9dAyvo+/Yd3H6/M+jvR8whGMB
        tx85vKmZ1YPICPNeHOYnIanAvd3mhEr9MuefN5HWOQ==
X-Google-Smtp-Source: APXvYqyRqFO8DnlUxTuulaeN51Ccoi/wNUL1xOjgvaLRhN641y5Hw/UsspKPB9nl9NukmCmvcMaNWtuiBw6YLY/JcLo=
X-Received: by 2002:a9d:10c:: with SMTP id 12mr3560362otu.123.1559614730649;
 Mon, 03 Jun 2019 19:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
 <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
In-Reply-To: <6b539c8b-c2fd-6c37-d645-ef714c0e29c9@intel.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 10:18:39 +0800
Message-ID: <CAMz4kuKXqTWfH0d=4hV_+k8ukYhihQP4QcqFQ+jpiQSu21TQ3g@mail.gmail.com>
Subject: Re: [PATCH 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Mon, 3 Jun 2019 at 21:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/05/19 1:12 PM, Baolin Wang wrote:
> > Set the PHY DLL delay for each timing mode, which is used to sample the clock
> > accurately and make the clock more stable.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> One comment, nevertheless:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index e6eda13..911a09b 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -29,6 +29,8 @@
> >  #define  SDHCI_SPRD_DLL_INIT_COUNT   0xc00
> >  #define  SDHCI_SPRD_DLL_PHASE_INTERNAL       0x3
> >
> > +#define SDHCI_SPRD_REG_32_DLL_DLY    0x204
> > +
> >  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET     0x208
> >  #define  SDHCIBSPRD_IT_WR_DLY_INV            BIT(5)
> >  #define  SDHCI_SPRD_BIT_CMD_DLY_INV          BIT(13)
> > @@ -72,6 +74,24 @@ struct sdhci_sprd_host {
> >       struct clk *clk_2x_enable;
> >       u32 base_rate;
> >       int flags; /* backup of host attribute */
> > +     u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
> > +};
> > +
> > +struct sdhci_sprd_phy_cfg {
> > +     const char *property;
> > +     u8 timing;
> > +};
> > +
> > +static const struct sdhci_sprd_phy_cfg sdhci_sprd_phy_cfgs[] = {
> > +     { "sprd,phy-delay-legacy", MMC_TIMING_LEGACY, },
> > +     { "sprd,phy-delay-sd-highspeed", MMC_TIMING_MMC_HS, },
>
> Did you mean MMC_TIMING_SD_HS

Ah, yes, my copy mistake and will fix it in next version.
Thanks for your reviewing and comments.

-- 
Baolin Wang
Best Regards
