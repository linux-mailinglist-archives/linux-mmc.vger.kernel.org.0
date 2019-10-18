Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE47DC349
	for <lists+linux-mmc@lfdr.de>; Fri, 18 Oct 2019 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442511AbfJRK7I (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 18 Oct 2019 06:59:08 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43030 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442497AbfJRK7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2019 06:59:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id p189so1240115vkf.10
        for <linux-mmc@vger.kernel.org>; Fri, 18 Oct 2019 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtA3V2IALA0Xv78U/72cjyEnqj42CR5j6kkzonbGR5Y=;
        b=iHwCtDtvN+KTXn/RwtvNwQGCGKUyAd9aSM5/gYvWV7+3et8OyYvGeQSXmjhj+GR2sd
         DW5uJ+OFJKkG0er6TA1lKGXqY1nTjTi0KRvfqzTCvKcmvj5skk1j+unOkMnnfsYP7GqE
         pC73iToVAVQTkOafuvqHysNZ9qi27d3sPQFeLo5TZpOQSAbAKLVv1vBArHqQOom4Eyim
         8D5nZeKcjdDvNjm83dU/jbLg0sRXvoDzCDSk4tJbmu+nGMLBaiSZdnKxnSwwcyaeR69U
         U5NGxqzclWg2VBwa6cqBYN+5eBmJQ02OiNWkHshFEX5BgoR+gelMXdE+oilY1XvjmTl9
         66EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtA3V2IALA0Xv78U/72cjyEnqj42CR5j6kkzonbGR5Y=;
        b=LSrygd5jNXgQ9p0jlmKtijIr8W1Sd8msJUkyKbAjhPilIu3VLQfDLnNAGjpeOvzxWv
         sgjDES9qAJl3aNsNVy4xGHEJooXDcI11rgpTW6ADNabSW7FHuTinMElBcI+2nGXiOHtA
         nvb1VjeViTh2s3XxmhREac2Fc/tmCbd90SA8KLIjuOgEHz6VnZ1XdpvZJAc1ZexviH6a
         1T2fVjqdcUfiwAqSacqUTfRAEQWN/pBwnk1QFazv5G7VWI2Clutz9zBmplSW6UoP8ozC
         Qsc71EjRZn5y1nQSM/ySb0w1G2WV0md15hsS8pyvvCEpHmaw6J1dP2l9FXOiKsiGSptC
         2+eQ==
X-Gm-Message-State: APjAAAXeVOLAx2xmzA4OQgIv/R5QoOZb5KxVaJBYJ4MnO/U4UzRPMXO/
        8q6F4Zuacf7UlW8H9LsenhJXPdR5ze+Ak4LgxIdQVgAC
X-Google-Smtp-Source: APXvYqw84njAK+3ljeXxfcyBQy775MIu35Bex1hH0yoREoalNLM4JFsVxJK4C23Ifc2BtdFfQ1Qf7RJmFlC3FEimVwU=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr4939018vke.43.1571396347472;
 Fri, 18 Oct 2019 03:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191014183849.14864-1-faiz_abbas@ti.com>
In-Reply-To: <20191014183849.14864-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:30 +0200
Message-ID: <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Oct 2019 at 20:37, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add a write memory barrier to make sure that descriptors are actually
> written to memory before ringing the doorbell.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes and by adding a stable tag, thanks!

BTW, do you have a valid commit that it fixes?

Kind regards
Uffe


> ---
>
> This patch fixes a very infrequent ADMA error (1 out of 100 times) that
> I have been seeing after enabling command queuing for J721e.
> Also looking at memory-barriers.txt and this commit[1],
> it looks like we should be doing this before any descriptor write
> followed by a doorbell ring operation. It'll be nice if someone with more
> expertise in memory barriers can comment.
>
> [1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
>     doorbell")
>
>  drivers/mmc/host/cqhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index f7bdae5354c3..5047f7343ffc 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -611,7 +611,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         cq_host->slot[tag].flags = 0;
>
>         cq_host->qcnt += 1;
> -
> +       /* Make sure descriptors are ready before ringing the doorbell */
> +       wmb();
>         cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
>         if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
>                 pr_debug("%s: cqhci: doorbell not set for tag %d\n",
> --
> 2.19.2
>
