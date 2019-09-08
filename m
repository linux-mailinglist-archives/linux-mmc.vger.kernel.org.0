Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9BACC0F
	for <lists+linux-mmc@lfdr.de>; Sun,  8 Sep 2019 12:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfIHKcx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 8 Sep 2019 06:32:53 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:35480 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfIHKcx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Sep 2019 06:32:53 -0400
Received: by mail-vk1-f194.google.com with SMTP id d66so2152669vka.2
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2019 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ASWzAgy8oE5NpcmHLOxDBhOTGv8uq0NwY0irR0ODJ4=;
        b=ZbOc8wfhdZkZWhuPtbvcF6/JE2/zauSFTi9h9SZhTJ1udTAfM0sVEzBCy8Fjv3sChF
         /ekgwurOiXyghgJjg4dU8e5CGyp2rnxqBsB3oEd0mRgu6A8IEFs+YZUN9fr0zmjCnb/u
         fqGWsnGaejK0m00nb64e8g9tLeK8Q4GlaRJDlnPf8lrYXIPrXJt4VWq7ljuBVRBj/AcB
         z7d6jDJcb1oU5gyzu6DPPzcdHh4Pm5+ND3Tle0GX6nQ8jQI0n5Z0CkPmXtLpxjNBJFqK
         5YLJ/ikD9Q55j0nNL/O8EUKDwBpNqzZyafi/yrtolQAO6zhDpMqtMIX/RITjO67wZ0OO
         Mk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ASWzAgy8oE5NpcmHLOxDBhOTGv8uq0NwY0irR0ODJ4=;
        b=JUf+heSd5/sgcdJBGev4+eXlEgBEd4dzI8xCxAEkaSrWaxEg7j2Mpxo7K/SXJDhv1m
         rX3z0bY8V6HjsdpNo3M8WCmzKyFrFgCz/g3PX6wkmX3uVP2CMyEeNr6rNlEtMOdJzawJ
         RjFbV+QUBai7YRh0U+H1jSXy2cTANxuGScm7WeInarxWhD1KoPNx0GlWDHvXkOxJrBXg
         gpeT8He7E27xkoW62uOzsyMHleQYeaxSF9W8bHnXW0UHsUNq+rRyuUjsBblbS9eRDvCa
         GAMS757LT/vWABQ7V62IFm8Wwi/s6glYuOBGI28HAkyRjmly86ObYVtOkyBklBTMs8vJ
         QDcg==
X-Gm-Message-State: APjAAAU+pgcUu6+zFmBH6Pf/qyhs1LvR1mtx9sH4qc6MTKjP0Vw0SCRL
        cQvtfjmtLw8c4jIrDgr9bBWjPRO0OeF1UqHDOlwzvUt3B3c=
X-Google-Smtp-Source: APXvYqwOkEy2UdfZ/j8kN/rbhgLhMRwT5zKU8HGZwha87r7j/cZutWcutYpnmC5aN2CUjnYRf0iIL00XmldrsTK9xsI=
X-Received: by 2002:a1f:5185:: with SMTP id f127mr8378309vkb.52.1567938772279;
 Sun, 08 Sep 2019 03:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190905045557.8812-1-drake@endlessm.com>
In-Reply-To: <20190905045557.8812-1-drake@endlessm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sun, 8 Sep 2019 12:32:16 +0200
Message-ID: <CAPDyKFr+-Hvm43iX=g1_2RD=AA1e+abtqi-K4XihcX_bmAJwug@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD
 host controller"
To:     Daniel Drake <drake@endlessm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux@endlessm.com, "ernest.zhang" <ernest.zhang@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 06:56, Daniel Drake <drake@endlessm.com> wrote:
>
> This reverts commit 414126f9e5abf1973c661d24229543a9458fa8ce.
>
> This commit broke eMMC storage access on a new consumer MiniPC based on
> AMD SoC, which has eMMC connected to:
>
> 02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog-if 01)
>         Subsystem: O2 Micro, Inc. Device 0002
>
> During probe, several errors are seen including:
>
>   mmc1: Got data interrupt 0x02000000 even though no data operation was in progress.
>   mmc1: Timeout waiting for hardware interrupt.
>   mmc1: error -110 whilst initialising MMC card
>
> Reverting this commit allows the eMMC storage to be detected & usable
> again.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Until we find another solution... applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 9dc4548271b4..19944b0049db 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -432,7 +432,6 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>                                         mmc_hostname(host->mmc));
>                                 host->flags &= ~SDHCI_SIGNALING_330;
>                                 host->flags |= SDHCI_SIGNALING_180;
> -                               host->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>                                 host->mmc->caps2 |= MMC_CAP2_NO_SD;
>                                 host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>                                 pci_write_config_dword(chip->pdev,
> @@ -682,6 +681,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
>  const struct sdhci_pci_fixes sdhci_o2 = {
>         .probe = sdhci_pci_o2_probe,
>         .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .quirks2 = SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD,
>         .probe_slot = sdhci_pci_o2_probe_slot,
>  #ifdef CONFIG_PM_SLEEP
>         .resume = sdhci_pci_o2_resume,
> --
> 2.20.1
>
