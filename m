Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BD26991E
	for <lists+linux-mmc@lfdr.de>; Mon, 15 Jul 2019 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfGOQbx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 15 Jul 2019 12:31:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42706 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbfGOQbw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jul 2019 12:31:52 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so11790657vsf.9
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2019 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9coYjSe3XSNr091GZSS9724rWMOjYgkm8g/YPUGrBk=;
        b=NYNAvMcRho+50ikquItIbaA8xyQqZTsW5KuU71/3Q+SoqDVsAy0+FM2d2PDcePt7/n
         11RZxGJC6mTRC4h6FGCGzw5ghhxx3RwnG0GjedgAFNGGoDc3a9QiHq+8ObcMmIqDsmmR
         J3Vsoi/0eyXbw2JYkw6d/qyG0Pcpoe3itkm/WnnZNuH1KiiwADvf3ntPy/+VrYE6PIw6
         uIF81NM9pWUyOV4tcN7jlhU8hIQWnXcFmd8zg9BnmqlN0/rWPA8H02F6iWBLylvyWZNz
         XJSLk/1VCaTu2yjDkpvSOUpRVRh2m0Rv0bmcg2VHCyu5QVYHl7BD6bBxYfh/jlUUzWJe
         HABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9coYjSe3XSNr091GZSS9724rWMOjYgkm8g/YPUGrBk=;
        b=PdO7Quat9NYSFDJHlHH6c+kvGr10RzC1uvogLD//hQ+daVJkkkB2H+5YHd4XqLU0Wk
         Vvnkp7h7j5c7Fwpve9bs3gopIYi8gJwZ3ctT2X2zA9aYeZk0Q9Tw6V7sR10PWr+yZWHe
         rrUSx0OtSxZ0w98eAEokUIbM5t9C0JZE2AX/LIV0xlnuabLpaQu7zphKvTcQeOkbukdc
         vXb/5qCQrwaeEjYGTX3YXx5lRt7DvLtBRqvM0y5NvDljDk+D48/Z1x0rwusJd19lgZje
         U1PXd+NtdnZ0DUcaZPzNRseOxnNkpQhHRUlstTRyp4le8hXwgN4i2zA7lqXq87aDOO49
         mScw==
X-Gm-Message-State: APjAAAWtMWEGX+Ev7APNFi3yBJ8GQVwNHVsbv/GSEfnCoJ/uKb/WrtsF
        QHpZVDA9QFLiKygbe/4ZaP+4sdG0Eyg5Xutt4V73Tw==
X-Google-Smtp-Source: APXvYqyUVL5RPnQWYVDvWMTPG8b/y4kpVO36hdyZcWBMkgiuUbpz8JwBx7OzH4gYy2hAxp1kCITo99T3NjrGPMBeorE=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr16907417vsc.200.1563208311475;
 Mon, 15 Jul 2019 09:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com> <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1559577325-19266-2-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jul 2019 18:31:15 +0200
Message-ID: <CAPDyKFpJPbpTnfA2cynFURyxFY_YCm7MRXw3m2nQyU+z=ZWsFA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: mmci: fix read status for busy detect
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 Jun 2019 at 17:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> "busy_detect_flag" is used to read & clear busy value of mmci status.
> "busy_detect_mask" is used to manage busy irq of mmci mask.
> So to read mmci status the busy_detect_flag must be take account.
> if the variant does not support busy detect feature the flag is null
> and there is no impact.

By reading the changelog, it doesn't tell me the purpose of this
change. When going forward, please work harder on your changelogs.

Make sure to answer the questions, *why* is this change needed,
*what/how* does the change do.

>
> Not need to re-read the status register in mmci_cmd_irq, the
> status parameter can be used.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 356833a..5b5cc45 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1240,7 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                  */
>                 if (!host->busy_status &&
>                     !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> -                   (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> +                   (status & host->variant->busy_detect_flag)) {

I suggested you to do this change through some of my earlier comments,
however I think it should be made as a stand alone change.

Anyway, when looking at the details in your series, I decided to try
to help out a bit, so I have prepared a couple of related patches for
cleaning up and clarifying the busy detection code/comments in mmci. I
have incorporated the above change, so let me post them asap.

>
>                         /* Clear the busy start IRQ */
>                         writel(host->variant->busy_detect_mask,
> @@ -1517,7 +1517,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                  * to make sure that both start and end interrupts are always
>                  * cleared one after the other.
>                  */
> -               status &= readl(host->base + MMCIMASK0);
> +               status &= readl(host->base + MMCIMASK0) |
> +                       host->variant->busy_detect_flag;

As I told earlier in the review, this looks wrong to me.

It means that you will add the bit for the ->busy_detect_flag to the
status field we have just read from the MMCISTATUS register. That
means the busy status may be set when it shouldn't.

>                 if (host->variant->busy_detect)
>                         writel(status & ~host->variant->busy_detect_mask,
>                                host->base + MMCICLEAR);
> --
> 2.7.4
>

By looking at the other changes in the series, I assume @subject patch
is intended to prepare for the other changes on top. But it's not
really clear.

Anyway, in that regards, the below is my observations of what seems to
be important part, when supporting busy detection for the stm32 sdmmc
variant (except the timeout things in patch2, which I intend to
comment separately on).

I figured, these are the involved register bits/masks:

MMCISTATUS:
MCI_STM32_BUSYD0 BIT(20)
MCI_STM32_BUSYD0END BIT(21)

MMCIMASK0:
MCI_STM32_BUSYD0ENDMASK BIT(21)

For the legacy ST variant, there is only one register bit in
MMCISTATUS that is used for indicating busy (MCI_ST_CARDBUSY BIT(24)).
There is no dedicated busy-end bit for the busy-end IRQ, which I
believe is the reason to why the current code also is bit messy.

It seems like the stm32 sdmmc variant have a separate status bit for
the busy-end IRQ, correct?

If I understand correctly by looking at patch3, you don't use the
dedicated busy-end status bit (MCI_STM32_BUSYD0END), right? Then why
not?

Thoughts?

Kind regards
Uffe
