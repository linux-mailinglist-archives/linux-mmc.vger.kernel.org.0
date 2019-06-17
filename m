Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692D847BB0
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2019 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFQHx7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 17 Jun 2019 03:53:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46937 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQHx7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jun 2019 03:53:59 -0400
Received: by mail-ua1-f67.google.com with SMTP id o19so3084133uap.13
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2019 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRW1fNYqfwgQBy9THQpXCwuo5cDKvcErh5obSg7YYNc=;
        b=rF1z+kGx4xXL8zfFmisXiiKRC1ok9357niHWA7JwibX0ET3Sg2Vx/C91G3nrLc+Xhe
         BPK1VcVetMEFD5keUYeTb5W3hxqOdM34b/M9bruL5im6NuFkKRqVC7jsMPkebP2tAn6Y
         D94jWFD4CUzmB3wQv0vDlpQdduzhIvtbUwbiHXA/jfeOFu2cvoIcibGdp+E+Bd3gGBoy
         3gl7atT4pvqbvXUtPRwvJqQds1zAPHerPuoQw/wouC1cnIz0xBuv7d33qJEKP6bN2kwZ
         CNzBAvYinLErfw6BiZX1TKiSPZVm6+weN+Ve92dW+5Ee4stiJZG0x7ywBtwPHFq7QAAV
         g3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRW1fNYqfwgQBy9THQpXCwuo5cDKvcErh5obSg7YYNc=;
        b=WuPn5uMXt9HpCf9DpyiLrLXOSpoXjy/xL9kmyI+xksUmGet/mjvZhciIrgIu+ZfFNV
         ZLSKeVHj8i1rmb1p4+6W3IMhNBV6rrUFYKsbmVyLSszL4STeMXETIPFnGZPd+tvnJ7lc
         /C8XnBqHCPRYBwl1rlUPZPguymLN3SNpGUXVGC/XEZ0rQzPZkeWXwzjF9u3OFlUwuqtI
         nx7YLb2DIyCUIa1CYhwAXwjaV34Do+4N3IAz9zimS25ESTck6LIIPkUr6i+OhArfDSXY
         HBoKgCpFhZvZOjkk1HL2LZChxmgQioMoTAihNgKvPRLuzl8vkadMcRiZbGoRir6UhjuI
         VZhw==
X-Gm-Message-State: APjAAAV5CEg8Xxx2/NFmL/F42pCaSz4DMf4txGn0se+3qgiweVToyOTG
        WeEcc+lI8q4nGEQDmW9mv27ba9RloDREoiR0qDNcRw==
X-Google-Smtp-Source: APXvYqyhLV0eZUsbwyc8+v3TnW8XR69RoxoH9782ZqeCtf+IvVa1gMZ7SgjScvGxko8mmZpldj50C+TaD9ZWqmsljgk=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr6656078uad.15.1560758038323;
 Mon, 17 Jun 2019 00:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190613234153.59309-1-dianders@chromium.org> <20190613234153.59309-3-dianders@chromium.org>
 <CAPDyKFrgXGf_9=H7G40fiUQj=da5WWRys_oim2azgL4FEOeUVA@mail.gmail.com> <CAD=FV=UA9i1eEi3Mx0WF-DnCnr4O4-MfOxa=axZOJtXzxbV7Tw@mail.gmail.com>
In-Reply-To: <CAD=FV=UA9i1eEi3Mx0WF-DnCnr4O4-MfOxa=axZOJtXzxbV7Tw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Jun 2019 09:53:20 +0200
Message-ID: <CAPDyKFqNUJospyV05ZC7Y894QB6a9LQ8cjdT+zrD9EQvm_OWRg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mmc: core: API to temporarily disable retuning for
 SDIO CRC errors
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Double Lo <double.lo@cypress.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Allison Randal <allison@lohutok.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> > > --- a/include/linux/mmc/sdio_func.h
> > > +++ b/include/linux/mmc/sdio_func.h
> > > @@ -167,4 +167,7 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
> > >  extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
> > >  extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
> > >
> > > +extern void sdio_retune_crc_disable(struct sdio_func *func);
> > > +extern void sdio_retune_crc_enable(struct sdio_func *func);
> > > +
> > >  #endif /* LINUX_MMC_SDIO_FUNC_H */
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog
> > >
> >
> > Besides the minor comments, this looks good to me.
>
> Thank you for the reviews!
>
> I'll plan to send a v5 on my Monday with the fixes assuming no new
> heated discussion starts up.  If it's less work for you, I'm also
> happy if you just want to make the trivial fixes yourself when
> applying.

It really doesn't matter to me, feel free to pick the option you
prefer. At this point I am just awaiting acks for the broadcom patces
and some clarity of what stable releases we should target for
non-tagged patches.

Kind regards
Uffe
