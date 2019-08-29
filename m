Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C67A1506
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfH2JdJ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 05:33:09 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43143 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2JdJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 05:33:09 -0400
Received: by mail-ua1-f65.google.com with SMTP id y7so931512uae.10
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwMS525ywtt6sOg3VAxDrxJAxwOW0CWRYuAHzYt0J9c=;
        b=oS3dg9bS3cPrcgG3vOeds6Of/Z1OhxHH73UTSEEvjU7LQ1QpYpJ0chV+hWPiPMuxth
         h7Awf8JulKMThePAbEgZUhZRbWVWQzNylBVGm90uwKXHvOIx5ZNbRzsohHMdpJg6gqJA
         3QKuzxTcr+kvW+arPvTtiX5ufTTwT4Lly1rMnYwTDxk37yXuHjs1OUZebbBGXp9+0B6S
         M/u5dKDxHju7704K8VWl5kP/MGnbJhnpXTZD/T4xXCmn2vgWEGTfmIP9+OOndzaVpDQz
         uHTfQ9XH65cFSil6BEoX816DV/tqY9tQ3sigPeehTuGujw3ArKxmssehbbVEpXpUIthD
         oITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwMS525ywtt6sOg3VAxDrxJAxwOW0CWRYuAHzYt0J9c=;
        b=lx9Ju+pXaaPKU7fD00275pYnPeAjI25UJx8QFgfxyKUVnCljuzCoO6wuIragRiuBON
         0rGoZX4gmoeD35kFhkQdAVI3hVRNZTbPlg31PmBFOnSNZtoS9Vu04gDvMOTorFQTIyx3
         eAhglOZqBlqr6pSVu5NJzfbSeIK9f0k0dhTOtNTDXG5xvwP22eMI0/GSRFfn4JQRpmNl
         opaB++653jUF7gDUNM7h04Z5Q98vQVxA7EMQerAUhGnakYQdTqHrCQjUzM+YwojWszN9
         UzWeqGRCb9tw37agAT12UmIu0GzKdMZKwj+zSoVg9mXgHVkXhQomzOMX5XSUEk+IyLU9
         JlNg==
X-Gm-Message-State: APjAAAWRdRa7We/unng2nA5NUyF02xSqn32ByZolfoyOegpjxSU7zXhQ
        cT5I9wSBEtTNw6+zC17LdkykUpDuiUt72yj9jfBDnA==
X-Google-Smtp-Source: APXvYqw4cMfDzwrNTgPt2rfd0EXbGJVRlkTiKDXTWWUi6fN0jj1iS+RcuKcfAvqHKkgKC3y15uSqQbomLBZcx4qiVk4=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr4257943uae.15.1567071188564;
 Thu, 29 Aug 2019 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 11:32:32 +0200
Message-ID: <CAPDyKFp_+YuPOjURiE0YhT0uotZi=P2sRVYNr3ejgZmrMaN=tA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/5] a few fixes for sprd's sd host controller
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

On Thu, 29 Aug 2019 at 03:47, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> With this patch-set, both sd card and mmc can be setup.  This patch-set was
> verified on Unisoc's Whale2 and another mobile phone platform SC9863A.
>
> Changes from v1:
> - Added Reviewed-by and Tested-by of Baolin;
> - Added fixes tag for all patches in this series.
>
> Chunyan Zhang (5):
>   mmc: sdhci-sprd: fixed incorrect clock divider
>   mmc: sdhci-sprd: add get_ro hook function
>   mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>   mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
>   mmc: sdhci-sprd: clear the UHS-I modes read from registers
>
>  drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> --
> 2.20.1
>

Thanks, but I amended the current applied patches, assuming the only
change change you did was to put the fixes tag on one single line (for
each patch).

Kind regards
Uffe
