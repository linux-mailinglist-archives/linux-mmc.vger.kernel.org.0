Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2784A400FBF
	for <lists+linux-mmc@lfdr.de>; Sun,  5 Sep 2021 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhIENBk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 5 Sep 2021 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhIENBj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2021 09:01:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F99C061575
        for <linux-mmc@vger.kernel.org>; Sun,  5 Sep 2021 06:00:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630846833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mrjGVFiOPqsdbJhlmm1IqiKCCQIVhCAj521c6QgqVM=;
        b=2Ssmz/nGTLxDypQ09h+gv3v+WyQtYzIIP94e/m9VP8G5jMRLmV99WbksWatpe7ei2611Tj
        ukf8q6vUbx1hIyG9i3AkQkn+8BYFkLhtJRlojjamC+rfBCUO7eYs/J0EBoRBNusSNLAVRM
        iryzslyn117MImHzeDQO6OZEsHLJYOUM2s8jF6GVCnfXOfASQie60mxgGPmglQ6R2ihHcC
        j0uOD4raeXKhmwPoMOY/yeSxlUTSWiAWhOjRe0sj9ogyVuqrI9gwCIVZd9PRNmwGqZw1dE
        O2rNrRaH4KLIam2o6W0LsTwr/HE6JmdPWnnN+5pYtsQbb9tKQuCuH1+Qk4s9jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630846833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mrjGVFiOPqsdbJhlmm1IqiKCCQIVhCAj521c6QgqVM=;
        b=uib9f4Z1JO1xwyZA8nqZ763uwURP/23thAsyE9yMPj5VN/yfDK1Tq663JHaGVc43I5tE6X
        vLlqa8qKC/dRHQAA==
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
In-Reply-To: <CAOMZO5BnPEnF-HNM7vCzeUrRW7BsQ-hhm4fcVmO_QieKf6oJsw@mail.gmail.com>
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
 <87czpqbq98.ffs@tglx> <877dfyaxpx.ffs@tglx>
 <CAOMZO5BnPEnF-HNM7vCzeUrRW7BsQ-hhm4fcVmO_QieKf6oJsw@mail.gmail.com>
Date:   Sun, 05 Sep 2021 15:00:32 +0200
Message-ID: <87y28b9nyn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fabio,

On Sat, Sep 04 2021 at 18:10, Fabio Estevam wrote:
> On Fri, Sep 3, 2021 at 5:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> I did as suggested and here is trace.txt:
> https://pastebin.com/VUfLRJ8a

Lacks a stack trace, but yes this one is the culprit:

kworker/u4:2-70      [000] d..1    87.940929: softirq_raise: vec=3 [action=NET_RX]

It has only interrupts and preemption disabled and it's in task
context. So if there is no interrupt raised and no local_bh_disable /
enable() pair invoked before the CPU goes idle nothing will handle the
softirq and the raised bit stays pending which makes the NOHZ idle code
complain.

> Also, while investigating this problem I saw a commit that fixed a
> similar issue:
> e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()").
>
> I then tried the same approach on the ath10k sdio driver:
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c
> b/drivers/net/wireless/ath/ath10k/sdio.c
> index b746052737e0..eb705214f3f0 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1363,8 +1363,11 @@ static void
> ath10k_rx_indication_async_work(struct work_struct *work)
>          ep->ep_ops.ep_rx_complete(ar, skb);
>      }
>
> -    if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags))
> +    if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags)) {
> +        local_bh_disable();
>          napi_schedule(&ar->napi);
> +        local_bh_enable();
> +    }
>  }
>
> and no longer get the "NOHZ tick-stop error: Non-RCU local softirq work is
> pending, handler #08!!!" error messages after launching hostapd.
>
> Is this a proper fix?

Yes. This is correct. See above.

Thanks,

        tglx
