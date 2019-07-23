Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1B7140D
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfGWIew (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 04:34:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40710 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfGWIev (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 04:34:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so26643411vsd.7
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aWJ/JAdMglOxtJEbcmhJOQynHm+bRWSKko1HR0L8QM=;
        b=RrXXi056DxpL0EJxsBWmPfr33KRPSH3qyJA5n+ARe+hn5ioEMNzySTXq8eNG7HeTlM
         OjYTKevZ30ZFcDe45F+x/kdYhN7jS8B9yu5TZR7W6a+IajWi075JzrJw97JXDfV1ICDV
         Y5UxKqLDnTpDxsLvXQCKMTcPz9FdpcLorBogr0F8OfG9ZiazZ7GdjDsVbmZf24V6v3Ha
         TBG0O0QXj2CWl1dHgCsVnB7x/tGde9A1i4BtPKOowhxxAISJeMG8wtu3sB+rR8akajk3
         H2nv+Vuxtyt/xPAccAPdOdB6ylTRed907F7Mxvev+A+37BbEjkAsXOf5zNL6TSj0VpBQ
         dGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aWJ/JAdMglOxtJEbcmhJOQynHm+bRWSKko1HR0L8QM=;
        b=aJTccfTsh58/jQIKdX3RBlga4V4oKHn6ZaklQxDaXoMJhaVc+VqXh/x85YqRXmOH0H
         4zErpDAp/4ZXpyXBOYzuWrUhVkjUe3bLREcb7BRe/hsoDEkthcEarl9GcjYGsEmkNIWM
         0O/l7KGcUNFka1UVXfG08z4UmD9zh/6Sf4wN4AZy0eH9zUV7UOhkukUNLyArNLEld+f+
         9WUjXwE9ftB3K+hcdKlbDfD9SyYZsnHM3db9WAg+0iAlvTPZ6RN9BlmYWTKLi9e6cwy9
         h/hLboMRW830hXw8cYm5f+rHF4feN4licz9itgf9oPr9nhbqnWJ0qn4njeqjSqSDFzPE
         f1aw==
X-Gm-Message-State: APjAAAXTr5RKYTK2M+Ntlei94FLW9mcJnGxfrlMWM/suEcZxbXyxrI40
        V07fdeKEJNX6vMZqCizLB7i328qjMQw0aRef7xWtxA==
X-Google-Smtp-Source: APXvYqzNs3gxI1Wh5NQNG8ZCg48rxs53uVG8u/pDP7mfsiX/Lxwsc5EvbVlfeuss2hmM0cibxkMOiwY/IT400RakZ5k=
X-Received: by 2002:a67:61c7:: with SMTP id v190mr45641136vsb.165.1563870890278;
 Tue, 23 Jul 2019 01:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190722111317.20177-1-ulf.hansson@linaro.org> <793757e2-5722-3597-4f1f-e5e021d1bd77@st.com>
In-Reply-To: <793757e2-5722-3597-4f1f-e5e021d1bd77@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 10:34:14 +0200
Message-ID: <CAPDyKFpzg5vmkmN2uNBRUm-GgEYp662ND-8C2csNABLo8jecAw@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: mmci: Clarify comments and some code for busy detection
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

On Tue, 23 Jul 2019 at 10:12, Jean Nicolas GRAUX
<jean-nicolas.graux@st.com> wrote:
>
> Hello Ulf, all,
>
> I tried this new patch and did not face issues so far.

Great, thanks!

> That is said, some comments below.
>
> Regards, Jean-Nicolas.
>
> On 7/22/19 1:13 PM, Ulf Hansson wrote:
> > The code dealing with busy detection is somewhat complicated. In a way to
> > make it a bit clearer, let's try to clarify the comments in the code about
> > it.
> >
> > Additionally, move the part for clearing the so called busy start IRQ, to
> > the place where the IRQ is actually delivered. Ideally, this should make
> > the code a bit more robust, but also a bit easier to understand.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v2:
> >       - Squashed patch 1 and patch 2.
> >       - Keep the re-read on the status register, but explain why it's needed.
> >       - Move the clearing of the busy start IRQ at the point it's delivered.
> >
> > ---
> >   drivers/mmc/host/mmci.c | 63 ++++++++++++++++++++++-------------------
> >   1 file changed, 34 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 356833a606d5..d3f876c8c292 100644
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
> > +             /*
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
> >               if (host->busy_status &&
> > -                 (status & host->variant->busy_detect_flag))
>
> To my mind, purpose of that if condition is to wait for busy end event
> while the one just below is to clear start event and unmask busy end irq.
> So I think maybe it's a bit late to clear busy start event ? What do you
> think ?

Before my change, we are always reaching this if clause, only once and
without having any other status bit set but the busy bit. It sounds to
me that this is actually the busy start IRQ that we receives, see more
why I think so below.

That said, by clearing the busy start IRQ here, we still only reach
this if clause, only once.

>
> > +                 (status & host->variant->busy_detect_flag)) {
> > +                     writel(host->variant->busy_detect_mask,
> > +                            host->base + MMCICLEAR);
> >                       return;
> > +             }
> >
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
>
> Why not clearing busy start event as soon as possible ? Maybe I am wrong
> but as far as I understand,
> we shall (always) enter that if condition before the one just above ?

Two things feel wrong about by clearing the IRQ here.

1) We have not yet unmasked the busy end IRQ and we don't have a bit
in the IRQ mask for the busy *start* IRQ (they are the same). Then we
are clearing an IRQ that we have not yet unmasked to receive, which
seems odd/wrong to me.
2) Even if we clear it here, we are still receiving the busy start
IRQ, as described in my comment above.

>
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

Kind regards
Uffe
