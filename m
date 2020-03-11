Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47230181C67
	for <lists+linux-mmc@lfdr.de>; Wed, 11 Mar 2020 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgCKPfI (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 11 Mar 2020 11:35:08 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44611 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbgCKPfI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2020 11:35:08 -0400
Received: by mail-ua1-f66.google.com with SMTP id a33so867356uad.11
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2020 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bW2b1foiADltfckt9kisNLeC6odtSToLupbG9QHAAA=;
        b=FybwXaSquXwQKMtYBLiRXsogg7nCSFa7VunIRDICPxkTrnOiqvaiJgKBYqaTz7hIi8
         8vEUYzdQLRD11NGkw1WojWFy1nCI3NCfjPCF/UevrHQu8Hn30+2vpznTEVxH0JmxuVvu
         7knxdHTT5dO+BvrkY8UzEgFsAYyOTVcr9PSGTkzS1U+GCwAu9pzga8Lx3o57emoYEpVU
         SM8Bdc6TkVT7IVUfpV5vjpP0WvYUPVkyYMXCRvy3reaEHRcXkNnJymu/0S6eaaueVYD9
         esrQDowEXifXEM1MLJwQHYXu1oP2O2MaUOBO+ijcfXhj+SAvg/fkdu1QHMcbXR1oLrqN
         d2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bW2b1foiADltfckt9kisNLeC6odtSToLupbG9QHAAA=;
        b=jV8Td2bgB1qNeGTohOTZh9lRtzPIMfrTtga6ja2rcohsSucQaOkdQip6VuMvcHI27o
         ihQS2jByzE/lvAybm0RBBpjv5LGrg7Hiq5+O8gQ73PZYfDyz+Zm20sMBxYGJQ3lNImD6
         lQXL1XGjc8n6yVGkWs/nuwKpCVM9xRaFl7qQff2Ahj4y9iCqkwV/JjiVZwHyh55TWrOU
         ZktsXhQz8RRrfkoUo/VCQsnZrgVtRyf7zhdVqFOs297IYmTppFCX2YhwYaLWdEQEYZRK
         LIR5qTzdgJAnzH46uuo7QIT4gr2px6eik0VJYi9DPvFq7eBV8p3QG/aANp3pMV/ShbQN
         N0PQ==
X-Gm-Message-State: ANhLgQ2hYacRqs0Yc+CqhnkWLe9YVoBOQ3hqJY6iiltGySybe8NqhzRI
        c8dvi8Ta4GpgHOtLjbKxe50kuQAF+6y5s980qYVVkg==
X-Google-Smtp-Source: ADFU+vuNhktE123R0SxiGW+jzJjuGId9sIHLyUMXSM/ML17sf0HSN53V/yX8MdPb+v19ZJ0BTJh92KN3XImSlKFOkwg=
X-Received: by 2002:ab0:7802:: with SMTP id x2mr2114133uaq.100.1583940906949;
 Wed, 11 Mar 2020 08:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org> <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Mar 2020 16:34:31 +0100
Message-ID: <CAPDyKFov_MwTjXarivgJ7+D_Oa1cgma3t1pDGQ8gkmeNJn4jDQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: cqhci: Update cqhci memory ioresource name
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Doug Anderson <dianders@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 4 Mar 2020 at 14:25, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Update cqhci memory ioresource name from cqhci_mem to cqhci since
> suffix _mem is redundant.
>
> Only sdhci-msm driver is making use of this resource as of now.
> No other vendor's driver is using it. So this update shouldn't affect
> any other vendor's cqhci functionality.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Corresponding binding change:
> https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
>
> Changes sicne V1:
>         - Updated commit text expalining this change affects *only*
>           qcom cqhci functionality.
>
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index e2ea2c4..e24b8ff 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -1077,7 +1077,7 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
>
>         /* check and setup CMDQ interface */
>         cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -                                                  "cqhci_mem");
> +                                                  "cqhci");
>         if (!cqhci_memres) {
>                 dev_dbg(&pdev->dev, "CMDQ not supported\n");
>                 return ERR_PTR(-EINVAL);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
