Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F7016A4B7
	for <lists+linux-mmc@lfdr.de>; Mon, 24 Feb 2020 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXLR0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 24 Feb 2020 06:17:26 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38511 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgBXLR0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Feb 2020 06:17:26 -0500
Received: by mail-vs1-f66.google.com with SMTP id r18so5438735vso.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Feb 2020 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUODaV4g/LRsT9laa1RfS2Gjv8Ee9++UWwJ4Sw725dw=;
        b=qCprhKufyO3XeXF1Aqp29azedeaBSklsvi974/pSi6i0bchDKMA4QiFMab5B21GrAe
         aPoY6lwFLf7Gw2xanmYW4sxSuFHgY4Xq8xejK43M4UWJXLiCyVhfobC/upBKa5N439Rh
         UrZkuSPo2w3vO+tp2Qmhv6CnKM9kdSkH+cU4BnfswdYciN8+EQDHPABtp4NjjVlp7/ic
         xYvgFba8E2IQfqzX74vKJdfmnIi94LtAwbuxmCOWrwXmDlG8oFC+0EpJuWcbvIOSb1EQ
         Z8MidMnV4IMTNouaTbNpnRGhV/z2LCi6ucZfAAdWcx2wW9juODo9RHEIz6Jw7SSBG2Ve
         Y+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUODaV4g/LRsT9laa1RfS2Gjv8Ee9++UWwJ4Sw725dw=;
        b=Ro7UtvSO9kJ4YmQPfu6PuN4efSC2vA6DN9PiFqmgA9UPbgK3/FlmnYHYjd1K1w4leT
         Q+rvVVUdXkiobe9iafg22civdUI8G3cBSCtbVWjG/Ha97be6Qri6iDvVNqmehi+9uwfx
         1kGTgp8tqJHKFWFdnI4/G6skomSfRK60wlxHTomeqq6c56cacCbjSyXRewHNOYZLKqXC
         fSr4mkwJfZsFiZcZmu94rNV2wkPTlFoTYcMkifgxmMAiJjJVW/y9NqnU3u9kOiZ6YQve
         AnMDv7x5eQzgNOuDAGDM6YVDLYFmkI22WvuMg98Dm35eQGfIpAwo2s1jSgoJXo10634O
         xh0A==
X-Gm-Message-State: APjAAAXXXnt2r053p8TyWyuZzfA4G/IK9WI7+hWVgLYeLr15h8UXJ9Zr
        vPzjScb3YM+Fr6c/gsb2e6gBWiiQyW6u48jFchrlwA==
X-Google-Smtp-Source: APXvYqykuSBIrbPM5IWUnabFpOFy1So7ym0Ta+33qTdsbP9AdXLucE6bZY92p+EYmu6x3IjSyvP9hqD43SlDiqCcj/g=
X-Received: by 2002:a05:6102:757:: with SMTP id v23mr26694580vsg.35.1582543045041;
 Mon, 24 Feb 2020 03:17:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com> <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
In-Reply-To: <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Feb 2020 12:16:48 +0100
Message-ID: <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Fri, 21 Feb 2020 at 20:44, Bitan Biswas <bbiswas@nvidia.com> wrote:
>
> On 2/21/20 1:48 AM, Ulf Hansson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, 20 Feb 2020 at 18:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >>
> >> On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>
> >>> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >>>>
> >>>
> >>> Try to restore the value for the cache flush timeout, by updating the
> >>> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".
> >>
> >> I have increased the timeout to 10 minutes but it did not help.
> >> Same error found.
> >> [  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
> >> [  608.684964] mmc1: cache flush error -110
> >> [  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
> >> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >>
> >> OTOH, What best i could do for my own experiment to revert all three patches and
> >> now the reported error gone and device mount successfully [1].
> >>
> >> List of patches reverted,
> >>    mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
> >>    mmc: block: Use generic_cmd6_time when modifying
> >>      INAND_CMD38_ARG_EXT_CSD
> >>    mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
> >>
> >> [1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346
> >>
> >> - Naresh
> >
> > Thanks for testing!
> >
> > This sounds a bit weird, I must say. Also, while looking into the
> > logs, it seems like you are comparing a v5.5 kernel with v5.6-rc2, but
> > maybe I didn't read the logs carefully enough.
> >
> >   In any case, I am looking into creating a debug patch so we can
> > narrow down the problem a bit further.
> >
> > Kind regards
> > Uffe
> >
>
> Hi Ulf,
>
>   I see that Jetson-TX2 / Jetson-Xavier suspend test is aborted and
> below error is seen due to the commit
> 24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9  ("mmc: core: Specify timeouts
> for BKOPS and CACHE_FLUSH for eMMC"):
>
> ##
> [  268.976197] Freezing user space processes ... (elapsed 0.001 seconds)
> done.
> [  268.984414] OOM killer disabled.
> [  268.987635] Freezing remaining freezable tasks ... (elapsed 0.000
> seconds) done.
> [  269.217471] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x58 returns -110
> [  269.224255] PM: Device mmc1:0001 failed to suspend: error -110
> [  269.230080] PM: Some devices failed to suspend, or early wake event
> detected

Is there also a print in the log about "Card stuck being busy!"?

In any case, it seems like the timeout error (-110) is happening way
too soon. The cache flush timeout is now 30s, but the timeout seems to
fire only a few hundred ms (at most) after the cache flush command has
been sent.

> ##
>
>   I find that from the commit the changes in mmc_flush_cache below is
> the cause.
>
> ##
> @@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
>                          (card->ext_csd.cache_size > 0) &&
>                          (card->ext_csd.cache_ctrl & 1)) {
>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -                               EXT_CSD_FLUSH_CACHE, 1, 0);
> +                                EXT_CSD_FLUSH_CACHE, 1,
> +                                MMC_CACHE_FLUSH_TIMEOUT_MS);
>
> ##
>
>   Do you have suggestion to try for the suspend errors ?

Just as a quick sanity test, please try the below patch, which
restores the old cache flush timeout to 10min.

However, as I indicated above, this seems to be a problem that needs
to be fixed at in the host driver side. For the sdhci driver, there is
a bit of a tricky logic around how to deal with timeouts in
sdhci_send_command(). My best guess is that's where we should look
more closely (and I am doing that).

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Feb 2020 11:43:33 +0100
Subject: [PATCH] mmc: core: Restore busy timeout for eMMC cache flushing

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index da425ee2d9bf..713e7dd6d028 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -21,7 +21,7 @@

 #define MMC_OPS_TIMEOUT_MS             (10 * 60 * 1000) /* 10min*/
 #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
-#define MMC_CACHE_FLUSH_TIMEOUT_MS     (30 * 1000) /* 30s */
+#define MMC_CACHE_FLUSH_TIMEOUT_MS     (10 * 60 * 1000) /* 10min */

 static const u8 tuning_blk_pattern_4bit[] = {
        0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
-- 

Kind regards
Uffe
