Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB129719C9
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfGWNxU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 09:53:20 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40993 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGWNxT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 09:53:19 -0400
Received: by mail-vk1-f196.google.com with SMTP id u64so8631375vku.8
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1sK0nKGFK6zaiwVQtF6a5/tShJyUfwRXg0bgR3l8qg=;
        b=QrO2PXy57yLdqOkfDXyeAbxvLFFSFJNOYcxLxJM8VCcYuH89G/a1vJeh8sJZX/InWe
         xKItIzoC8tzQ/ZUgezVyTV8OyLBEBVZaxX8ID2jgc04g3hAK5FHm/eL6zNInvGfCIaVk
         vgSaBjPzZPc0/h3KMTCDeQburUzdg/4Pxyv5cz2P8qPgA4NIQV3R+R6ofttYgwzKdmWo
         HDvWZegHflrpMn89DY/GtFBD/VAyG7AwhFpm7mucPm5ez6yUbadAQQALCHyscCMtvzDu
         cVXHedewLHLIb6KVdfcxItgU/lFJS8dkmJG+X0MD9b947/jImvQIxvjiwV8JwjaTr1/6
         +OLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1sK0nKGFK6zaiwVQtF6a5/tShJyUfwRXg0bgR3l8qg=;
        b=KOhNH9AHEV8AOjQQxyI5FCM7q94GuiN733A0nG9wIRlNBJz/vGiTYE+tyAAVljb0Pa
         oft9zcpccDzIemGwfcPpAAxXa4/zZo6AMozc6TE2EZFfkB+ydoNO1sAFCwR97DU4OhhB
         AyzHnSXdIJS3tXFHrL541OZfakPlRPxKE+IAsE3wHok/Kc7FOLKWzujwu8pJGPn4KVgx
         /wING4OVX2+0fxw+QhzL8rGwjXsTm4CaPE92XqUawXpYBZJoZqRnQ1dmzZMMUysNf8N8
         9qEpoCO6gA3qQ4Filf/z8MzeayF9Jgt7NvZYq1+nLxU2igKQftKmt/A2pSUINyHA3y5R
         LP5w==
X-Gm-Message-State: APjAAAXPKr+btiZ8+MYuVoUUl1f2wgTljfwaAJs7joPkaEEka+hAqbWY
        lB23zCW7efbnwkU0Jew+5K38WmSHF0jDgiPjgm/ifA==
X-Google-Smtp-Source: APXvYqxiBqAhDklij6HVoEH1l3IBIGX4t1zAjbxQdjfP+O+OULkBxvaYvskwELEAzuxFyG7UbXdWnXhdkYBDV9CutRs=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr27697668vkk.36.1563889998677;
 Tue, 23 Jul 2019 06:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190723122809.17509-1-ulf.hansson@linaro.org> <7a135c30-d659-a58e-4bb1-0daceee17c97@st.com>
In-Reply-To: <7a135c30-d659-a58e-4bb1-0daceee17c97@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 15:52:42 +0200
Message-ID: <CAPDyKFpb=_LYgY3f9jMjGuzLkix=NngxiRWNJXS8Mq7d4NA+nQ@mail.gmail.com>
Subject: Re: [PATCH V3] mmc: mmci: Clarify comments and some code for busy detection
To:     Jean Nicolas GRAUX <jean-nicolas.graux@st.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ludovic BARRE <ludovic.barre@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 15:00, Jean Nicolas GRAUX
<jean-nicolas.graux@st.com> wrote:
>
> Hi Ulf,
>
> I did a quick test booting on emmc with that new patch.
> Looks good to me.

Thanks, I will take that as a tested/reviewed-by tag and amend the
patch with that when I queue it up.

Kind regards
Uffe

>
> Best regards,
> Jean-Nicolas.
>
> On 7/23/19 2:28 PM, Ulf Hansson wrote:
> > The code dealing with busy detection is somewhat complicated. In a way to
> > make it a bit clearer, let's try to clarify the comments in the code about
> > it.
> >
> > Additionally, move the part for clearing the so called busy start IRQ, to
> > the place where the IRQ is actually delivered. Ideally, this should make
> > the code a bit more robust.
> >
> > Finally, to improve understanding of the code and the sequence of the busy
> > detection, move the corresponding code around a bit in mmci_cmd_irq().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - Move some code arround to make it even more clear how the busy
> >       detection works. Updated the changelog accordingly.
> >
> > ---
> >   drivers/mmc/host/mmci.c | 69 ++++++++++++++++++++++-------------------
> >   1 file changed, 37 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 356833a606d5..4c35e7609c89 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -1222,47 +1222,58 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
> >             (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND)))
> >               return;
> >
> > -     /*
> > -      * ST Micro variant: handle busy detection.
> > -      */
> > +     /* Handle busy detection on DAT0 if the variant supports it. */
> >       if (busy_resp && host->variant->busy_detect) {
> >
> > -             /* We are busy with a command, return */
> > -             if (host->busy_status &&
> > -                 (status & host->variant->busy_detect_flag))
> > -                     return;
> > -
> >               /*
> > -              * We were not busy, but we now got a busy response on
> > -              * something that was not an error, and we double-check
> > -              * that the special busy status bit is still set before
> > -              * proceeding.
> > +              * Before unmasking for the busy end IRQ, confirm that the
> > +              * command was sent successfully. To keep track of having a
> > +              * command in-progress, waiting for busy signaling to end,
> > +              * store the status in host->busy_status.
> > +              *
> > +              * Note that, the card may need a couple of clock cycles before
> > +              * it starts signaling busy on DAT0, hence re-read the
> > +              * MMCISTATUS register here, to allow the busy bit to be set.
> > +              * Potentially we may even need to poll the register for a
> > +              * while, to allow it to be set, but tests indicates that it
> > +              * isn't needed.
> >                */
> >               if (!host->busy_status &&
> >                   !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> >                   (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> >
> > -                     /* Clear the busy start IRQ */
> > -                     writel(host->variant->busy_detect_mask,
> > -                            host->base + MMCICLEAR);
> > -
> > -                     /* Unmask the busy end IRQ */
> >                       writel(readl(base + MMCIMASK0) |
> >                              host->variant->busy_detect_mask,
> >                              base + MMCIMASK0);
> > -                     /*
> > -                      * Now cache the last response status code (until
> > -                      * the busy bit goes low), and return.
> > -                      */
> > +
> >                       host->busy_status =
> >                               status & (MCI_CMDSENT|MCI_CMDRESPEND);
> >                       return;
> >               }
> >
> >               /*
> > -              * At this point we are not busy with a command, we have
> > -              * not received a new busy request, clear and mask the busy
> > -              * end IRQ and fall through to process the IRQ.
> > +              * If there is a command in-progress that has been successfully
> > +              * sent, then bail out if busy status is set and wait for the
> > +              * busy end IRQ.
> > +              *
> > +              * Note that, the HW triggers an IRQ on both edges while
> > +              * monitoring DAT0 for busy completion, but there is only one
> > +              * status bit in MMCISTATUS for the busy state. Therefore
> > +              * both the start and the end interrupts needs to be cleared,
> > +              * one after the other. So, clear the busy start IRQ here.
> > +              */
> > +             if (host->busy_status &&
> > +                 (status & host->variant->busy_detect_flag)) {
> > +                     writel(host->variant->busy_detect_mask,
> > +                            host->base + MMCICLEAR);
> > +                     return;
> > +             }
> > +
> > +             /*
> > +              * If there is a command in-progress that has been successfully
> > +              * sent and the busy bit isn't set, it means we have received
> > +              * the busy end IRQ. Clear and mask the IRQ, then continue to
> > +              * process the command.
> >                */
> >               if (host->busy_status) {
> >
> > @@ -1508,14 +1519,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
> >               }
> >
> >               /*
> > -              * We intentionally clear the MCI_ST_CARDBUSY IRQ (if it's
> > -              * enabled) in mmci_cmd_irq() function where ST Micro busy
> > -              * detection variant is handled. Considering the HW seems to be
> > -              * triggering the IRQ on both edges while monitoring DAT0 for
> > -              * busy completion and that same status bit is used to monitor
> > -              * start and end of busy detection, special care must be taken
> > -              * to make sure that both start and end interrupts are always
> > -              * cleared one after the other.
> > +              * Busy detection is managed by mmci_cmd_irq(), including to
> > +              * clear the corresponding IRQ.
> >                */
> >               status &= readl(host->base + MMCIMASK0);
> >               if (host->variant->busy_detect)
>
