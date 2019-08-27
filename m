Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B679E9DB
	for <lists+linux-mmc@lfdr.de>; Tue, 27 Aug 2019 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfH0Nrd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 27 Aug 2019 09:47:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46348 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0Nrc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Aug 2019 09:47:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id x20so13236911vsx.13
        for <linux-mmc@vger.kernel.org>; Tue, 27 Aug 2019 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPQYrv4BEVdVy6rwgRtH4GhcTMxzFg15QggsylhIIPs=;
        b=m3fjzn0i0Q8f5nrO6+S3Ud8xp0u5R2TY61vWm5o63x1ntJ+n2TtXHHYBd0cWkbhNAg
         SsL/gDXdqe+eYw5ukeaZmqwS0mB5QEuoVwFIU4kOJR8hVh/szp55kFxNmT4Rh2rsMc1b
         fCtMgID+67KH0ZfkzfcjbHym6yv4meB8n/MO7NEz6NW2rS+b5gABuIWCzp4yRxZj+EDm
         EIaA65c60gQjERUfx6TEG6pmtpeSWKVZLUdWqLj5cunS+5B0aHPOYXczQLvSBMfreoGo
         2MEOhMCyHUfvaQPvggzyXejyChUpR3aRx2YbF37NhBSXWp18MnyySkCvN/iPLu1cxiPs
         GKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPQYrv4BEVdVy6rwgRtH4GhcTMxzFg15QggsylhIIPs=;
        b=XwrJUiHkYNfoupCvhkxmC41HKrSfs88275kRr9A19HPHry46wPJ7+ZewhIrMWi/DI9
         fYIKVEGk4FI+FJlHcpSFaZQ5TsKULKH/DKyBKBQMM9gi3HZmylBPGIz2nQ25yhPD3gFy
         9kTQYiT+HATthw4QMUWOOuWDRWO0DhsiHdB722nIVVFkB/qlCvlp5GnlXriXNw2Trp/3
         gmzoFp2sj7tMisKn12i+OwpneX3EI8pNDRu9lhq8xLudOBJ+Fa2fkzAyy/O/dLSL5Dyj
         tL/qSewXyBlJWiJV5zlEULjAnnzasbAnuIICmnO5nwb8YgVSYIAeb0cARmSPhfIT+aat
         gGIg==
X-Gm-Message-State: APjAAAXm+BV7d0gu2giOj6kcGD42BIJZTvLfGVh/TdrQxvTl4P/aVQ+x
        oqLAmL5GNBglnt4EX8v7G7LrZcSRK0Fnt8D7Acavqg==
X-Google-Smtp-Source: APXvYqxj3tnsaHq8DgViGsAoJo9rw8QwkeZH6ZUISBOvBLXIBdN1U29SC597LP2qvis6MuTgFBGdgzDX0uchvgR7WCg=
X-Received: by 2002:a67:fe4e:: with SMTP id m14mr14244540vsr.34.1566913651835;
 Tue, 27 Aug 2019 06:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:46:55 +0200
Message-ID: <CAPDyKFrpvtS9mHO7xN=cbrMHWN+ydPw08mF9oXtNW-TOMsP7Ew@mail.gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for sprd's sd host controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Aug 2019 at 05:18, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
>
> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci: sprd: add get_ro hook function
>   mmc: sdhci: sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci: sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci: sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

Looks like the entire series should be tagged for stable and having
the same fixes tag as patch1. No?

Kind regards
Uffe
