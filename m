Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22272D0AA9
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Oct 2019 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfJIJNA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 9 Oct 2019 05:13:00 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45452 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJNA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Oct 2019 05:13:00 -0400
Received: by mail-vk1-f194.google.com with SMTP id q25so366511vkn.12
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2019 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/4hXJ2P5thQjL8BZ4wbLsS4F+qlk2Hz+i7D5Bd6mvM=;
        b=J2opt7Ir85befVRMF6lGkdCHwViRgg6EYr40E7L/sxhguVLAVBxGdF6YnHdd87NmFi
         R1kLC1pM91GPv7AqibnD7i7jtV0Efrkub6VFyvhRBj855sFJAOLS+7zTo2hM4u0cN04O
         OI5CjIOdd4JMUEOPfTnw4IKgEe7rsUFPjUcmxy7K9ikliGzHvfW7HyVFOqv2TKldORpF
         iNj/kKIKEDA52DB0bjhJJHpo8Booqq+lyhUpa+4MK8G2zXLQp/dGhsw9yi333zctsh7F
         YO6WOsGmSCPz/EYDjTsc1sh/VvLwcMICVfEY5fSUPCI96ENOEGyO1peqhnfrCxTB6QXL
         BTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/4hXJ2P5thQjL8BZ4wbLsS4F+qlk2Hz+i7D5Bd6mvM=;
        b=GA9+2vIdMsq9sW4YgiJiGQpg8+e8y4P5Fm+hOuWU8AIB/tdVGrzFzCbRLvN0uN2vZT
         7cE55wzYoCwAvCiF1hC7EKgVqnXqYy9KbsYuLvGo5U1KHQ51V+vW/tVCpONURKSMOQyb
         6SWjgKWm/6Js5vla0A+Ee/rC+sfFIRXApD1eKlPp/Z5bOXeJ+PzlnO2syLYhkwDzbY2c
         CoGU84VoQoQaNlCrFI+I1yE9RtzXLvU99BFkX23ZL/2ODuwPC8Q+IX2Ub045dYEV3gxh
         UJhigPtIP9SC3nv2wBztpVchmQv9qnRYTcoTIIcKXcIDLE78yhZBPymRcIMjxiQgWi+H
         PPUw==
X-Gm-Message-State: APjAAAWlZ/E5raW/GDhqPK6WhA9uFydUprNBVRSB+JHDbdSxDXLzRbTD
        BRbA3NyU8uZ2DvU3CPmkx96Nd31QCSJWLgkHQua22qQC
X-Google-Smtp-Source: APXvYqxsO740Ct4rsidJ0kq5+1xxkCvRCKQBOQSD/zCdU68ceTq0F0K8ccYuS84qF5hAhSWs6vmZgSmuMm/rbhPpLJ0=
X-Received: by 2002:a1f:ae0a:: with SMTP id x10mr1448504vke.25.1570612378948;
 Wed, 09 Oct 2019 02:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <1570182260-135818-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1570182260-135818-1-git-send-email-zhengbin13@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Oct 2019 11:12:22 +0200
Message-ID: <CAPDyKFqRTGtQ0sS43_rkLyKrokq7g9ZLQ8LmUSorWUtXmksgnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Make function amd_sdhci_reset static
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Oct 2019 at 11:37, zhengbin <zhengbin13@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/mmc/host/sdhci-pci-core.c:1599:6: warning: symbol 'amd_sdhci_reset' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 659878a..de50e1d 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1596,7 +1596,7 @@ static u32 sdhci_read_present_state(struct sdhci_host *host)
>         return sdhci_readl(host, SDHCI_PRESENT_STATE);
>  }
>
> -void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
>         struct pci_dev *pdev = slot->chip->pdev;
> --
> 2.7.4
>
