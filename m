Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FC4631D
	for <lists+linux-mmc@lfdr.de>; Fri, 14 Jun 2019 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFNPmL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 14 Jun 2019 11:42:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35176 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfFNPmL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2019 11:42:11 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so6799173ioo.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2019 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhlu0KMAQ48ehIhdtg955Nb+uyGa0rTx6PsvOc4/bWs=;
        b=eVt6qzm9nXevPTFXbZgxmAtEkvXaLkUjLCMRS4NRFw5E8bHPugqIBKw2Zy8f76G3gc
         XgjLXpt7x5FC/qIUqfcQRTLtWsacsFnyMv13TjVo6utfbQdrb6D1XNxWphsmrSZXIYoI
         7Sd75nVsRAhaKiAuHkiKmZDt4T+nRWyKal/ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhlu0KMAQ48ehIhdtg955Nb+uyGa0rTx6PsvOc4/bWs=;
        b=GAr/qT+BnfCave9OQMI+Mo9a+gaJZOT1aYFXRdtixosgGc2bFFtna5iOsPYUza1ZmW
         QOt3Z0hOdUa+30cM6JA9kr5o2Ax0oVKa0FiD3nVlPbHL2gYaBU4tDQfDQl3HBzLO/cCZ
         PaoZwnvXgZDE+xBEcYAxnTPd+2gxbkbCk/rPfaqBQ19LCEObGAn/TGqa2to6S29ouPj9
         LM/nHB+UUxNm0e4nlMMploGVDtvoKPl/trOyH/l4/rDNukANaL2y6I3VOD+H5yhUf4NQ
         pyIxbnqWsHKJKmyiCOtmaJug1OYkxPpu6NCw1PpJ0P/rAzRlqpUjkbxA4k6Au0GX54yF
         0G0g==
X-Gm-Message-State: APjAAAWAP98fRkbwF5k95CebMp/J8TOL81XTTwneyuqZ6s5p2el6mNpC
        Y4vP5K34DU4yykYfa0rDukgPW5jqUbU=
X-Google-Smtp-Source: APXvYqxUVoSzYpYte+hvwJXwHfBPnmvIX4RDtenDEYnaQMCnpurGpCqo/PN9SysqCpfejcJxN8jFEw==
X-Received: by 2002:a6b:c80a:: with SMTP id y10mr11350857iof.170.1560526930351;
        Fri, 14 Jun 2019 08:42:10 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id t4sm2721911iop.0.2019.06.14.08.42.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 08:42:09 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id n5so6684493ioc.7
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2019 08:42:09 -0700 (PDT)
X-Received: by 2002:a5d:885a:: with SMTP id t26mr3842557ios.218.1560526928935;
 Fri, 14 Jun 2019 08:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123221.11580-1-ulf.hansson@linaro.org>
 <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
 <CAPDyKFqR-xSKdYZYBTK5kKOt1dk7dx_BjedHiDOKs7-X4od=dg@mail.gmail.com>
 <CAD=FV=WODbZa1fBrLbJBsd77xn5ekHWjks-ydxOSzjdBK83Rmg@mail.gmail.com> <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Jun 2019 08:41:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ujb=_jEFMdxLPW6tYwb9DZo5-RZ8BVuyq5DdFQ5jJbQw@mail.gmail.com>
Message-ID: <CAD=FV=Ujb=_jEFMdxLPW6tYwb9DZo5-RZ8BVuyq5DdFQ5jJbQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is suspended
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 14, 2019 at 4:56 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > I was more worried about the safety of mmc_card_set_suspended()
> > itself.  That is:
> >
> > #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
> >
> > ...so it's doing a read-modify-write of "state".  Is that safe to do
> > without any type of locking?
>
> In this case, yes I think so.
>
> The point is, it really doesn't matter if the reader (work or thread),
> reads a non-updated value, because the synchronization is managed by
> the later mmc_claim_host() and the cancel_delayed_work_sync().

If this were just an "int" then perhaps, but this is a bitfield.  So
if someone else updates the bitfield at the same time then we can
fully clobber their modification or they can clobber ours, right?

task 1: load "state" from memory into CPU register on cpu0
task 2: load "state" from memory into CPU register on cpu1
task 1: OR in MMC_CARD_REMOVED
task 1: write "state" from CPU register on cpu0
task 2: OR in MMC_STATE_SUSPENDED
task 2: write "state" from CPU register on cpu1

...so now we've clobbered MMC_CARD_REMOVED.  ...or am I just being
paranoid here and everything else in "state" is somehow guaranteed to
not be touched at the same time this function is running?


-Doug
