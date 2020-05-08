Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8091CA2A0
	for <lists+linux-mmc@lfdr.de>; Fri,  8 May 2020 07:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgEHF0h (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 8 May 2020 01:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgEHF0h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 01:26:37 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1330C05BD0A
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 22:26:35 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a5so373960vsm.7
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 22:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgXEH2RG1EUF/osFI6e00b26mIaF+BkthMPU4Amf75U=;
        b=aQxYapeY3RhEj3QL+T0cTy4xQcneFUuBAt8xTEY2IXRwEOOVRYsKFr1vFpbknIr7TQ
         Dt6Sg0Y7pSFJBAiB17pgomIr28oE2tVknu4W9Kv7SKPx0Su1+iO83SgeJib8yog72aod
         CYvnQHz6m0I97taYXOmH/9t8sac2Mj9xpoRaiRC7Urd2KbpcB6xMFeq4JWglybksHYae
         0suCF36vSePFEYyetLKwBK08CUFHmo/nPc8dhhqiCEotWsV4V70GtePv6YmEp6G/d/E0
         hk2LE8bxRcbIcDeUCNSa0nnVBqLEDSenIS60AyrCG2rp0clckoQmFtpu/VhJKE7OD5HT
         5wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgXEH2RG1EUF/osFI6e00b26mIaF+BkthMPU4Amf75U=;
        b=VDjIUlKTyypiqZXD/yLMiSG2JrNLZ60r0AADKJH95IgQ/xoh1QkG2qznb4GL1fr2RU
         fDRN6w2YRoUI0W1df01+f3EDNyHuCjHXhJBAWDcAIcnSF0SO3I4Se4vKtZd/SK41qmCb
         qM8gZe/9w5N5+EzeVz/COJtsU1jiG2FZqQSpnl3A5dQvJAzvyQbcwrTvPbMlwtYLIV0T
         3qTvqM/yblWNvtDZKwbR8DwslWULh1u+WKWmTvWOmYQYBfluN8o9HW2EpknLaQ2zhIft
         yNrHTjzJ+AzN35vuQXnMstZaVwJz8GgvvgKZgktNpt9y73rnSSEml/j+JE9ji6qIghEj
         kLEw==
X-Gm-Message-State: AGi0Pua86rgSZqj9U0O1IwpckrbFWPHNPf1p1mY27o/1d56a2GE3EuGk
        tLRLMktm2QOnQLZJkkbgado3Bitn0dd7wEHyVThuGw==
X-Google-Smtp-Source: APiQypIrnxR8E4rtJEWtj/6ZH8t5DZDcf7RygyXFGfVM1Io8rU8yL+5jnboGDWJNeT0QTfXFiWaC/4h8RJ4VKlAz4Go=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr567817vsd.35.1588915594812;
 Thu, 07 May 2020 22:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <1588775643-18037-1-git-send-email-vbadigan@codeaurora.org>
 <1588775643-18037-3-git-send-email-vbadigan@codeaurora.org>
 <b4a01f2c-479a-2a23-58b7-64f16cbc17a2@intel.com> <66747f4c-e61f-509f-a3cc-7e3499a844e4@intel.com>
In-Reply-To: <66747f4c-e61f-509f-a3cc-7e3499a844e4@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 07:25:58 +0200
Message-ID: <CAPDyKFo10JFbe7ZFnRBE2e55eGs-odAWYxU+Ep0S74003aLGpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Fix request completion in the CQE timeout path
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 May 2020 at 16:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> First, it should be noted that the CQE timeout (60 seconds) is substantial
> so a CQE request that times out is really stuck, and the race between
> timeout and completion is extremely unlikely. Nevertheless this patch
> fixes an issue with it.
>
> Commit ad73d6feadbd7b ("mmc: complete requests from ->timeout")
> preserved the existing functionality, to complete the request.
> However that had only been necessary because the block layer
> timeout handler had been marking the request to prevent it from being
> completed normally. That restriction was removed at the same time, the
> result being that a request that has gone will have been completed anyway.
> That is, the completion in the timeout handler became unnecessary.
>
> At the time, the unnecessary completion was harmless because the block
> layer would ignore it, although that changed in kernel v5.0.
>
> Note for stable, this patch will not apply cleanly without patch "mmc:
> core: Fix recursive locking issue in CQE recovery path"
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: ad73d6feadbd7b ("mmc: complete requests from ->timeout")
> Cc: stable@vger.kernel.org
> ---
>
>
> This is the patch I alluded to when replying to "mmc: core: Fix recursive
> locking issue in CQE recovery path"

Looks like the patch got corrupted, I was trying to fix it, but just
couldn't figure it out.

Can you please re-format and do a repost?

Kind regards
Uffe

>
>
>  drivers/mmc/core/queue.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 72bef39d7011..10ea67892b5f 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -110,8 +110,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct
> request *req)
>                                 mmc_cqe_recovery_notifier(mrq);
>                         return BLK_EH_RESET_TIMER;
>                 }
> -               /* No timeout (XXX: huh? comment doesn't make much sense) */
> -               blk_mq_complete_request(req);
> +               /* The request has gone already */
>                 return BLK_EH_DONE;
>         default:
>                 /* Timeout is handled by mmc core */
> --
> 2.17.1
>
