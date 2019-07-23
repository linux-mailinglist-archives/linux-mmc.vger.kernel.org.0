Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD34E71790
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbfGWL4t (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 07:56:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35403 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfGWL4t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 07:56:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id u124so28609546vsu.2
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SgTopY5qvDgcsmFCs1vxrGU+e5UFPTqCsHHUAGdNy8=;
        b=Qk5G5YADGVFkvr8Tf/Rtb9f8yeku3Jglwe6AdDzfqQtScsFavyaJbCaGLexYhYfqBZ
         FCMd+Sl0KKGH9YLuevLSRUliGeVa7zOdaI6FQqeCLGsr1Abr3wHVjKZLft0K28ACB7ym
         yjRP2bDE8MGENsHrEQnK0LbVSARBkmIV3SfKxWGn6T+M2yExdl9I2814xY1B6lxGNmOz
         zH04V2y38G4KPMht4MFqL+cl7tC5dZyAt+xaX2sqZRisF8YsTV14vzY3j1/uMF/vfim0
         NaK2URRQh0a6aRQVv9dXTVfQ4tLhEpPIued5kJDc6ekwNpzZuLAUXQfi/oHUPIyR5tTL
         z12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SgTopY5qvDgcsmFCs1vxrGU+e5UFPTqCsHHUAGdNy8=;
        b=SNSPFCjDxVp1Ld2JNY160mYnAjIPBzyvY9D43DjfFNrxVbRVsOZSn2kG7ksZAnohfx
         QhQIvXD6dTrYtoVhOuwiogyFXspa17vzKRZwhNAe6NsV96kwp8taw5oNjDEP2VLWCZ1t
         28Vb9KYCwx+xb8rKL2fcmSc7t4GvEzGym84pqF6GiXuAPb9haYi6+MpxCfocOPVPy/Wj
         CBBp5V/pb3MWsNhdWSAhiBmW49QPISPNM6NwfHhK0oUnJbfrKJ3Yipw5UzeBPmYL4xHN
         nUch//GtgTGz/KpnINuBiLJ+v3b5yhLKJXdXP8w7gM0bjkz/WrvhBEbluoM4SH4cbqw0
         srjg==
X-Gm-Message-State: APjAAAXc3UqcfWnDQ+Y9hiWh/Qf0T3L5WpX7fuWDB1pePfSYE94dRPXz
        jFSrrTFHQlZCqXkFllCqb8f4zbkblvvG7sYHgUaUjQ==
X-Google-Smtp-Source: APXvYqy0E6lD5Cjsj1u+Ge7z+mFuVYSRgKZqVeiH8/gjlyHk8CfQLeNF1/WaYVn/fvfudXpCJCJBVpWfwZX+rMhBOlI=
X-Received: by 2002:a67:7a90:: with SMTP id v138mr46648139vsc.200.1563883008287;
 Tue, 23 Jul 2019 04:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190722111317.20177-1-ulf.hansson@linaro.org>
 <793757e2-5722-3597-4f1f-e5e021d1bd77@st.com> <CAPDyKFpzg5vmkmN2uNBRUm-GgEYp662ND-8C2csNABLo8jecAw@mail.gmail.com>
 <1840c0ea-7aed-8a6b-3413-a0b5a8f87381@st.com>
In-Reply-To: <1840c0ea-7aed-8a6b-3413-a0b5a8f87381@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 13:56:12 +0200
Message-ID: <CAPDyKFp-dCJ_vB-svjabO-DRs4hhAtaxsxoNC9VQn-2PsA=V4A@mail.gmail.com>
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

[...]

> >>>                /*
> >>> -              * We were not busy, but we now got a busy response on
> >>> -              * something that was not an error, and we double-check
> >>> -              * that the special busy status bit is still set before
> >>> -              * proceeding.
> >>> +              * Before unmasking for the busy end IRQ, confirm that the
> >>> +              * command was sent successfully. To keep track of having a
> >>> +              * command in-progress, waiting for busy signaling to end,
> >>> +              * store the status in host->busy_status.
> >>> +              *
> >>> +              * Note that, the card may need a couple of clock cycles before
> >>> +              * it starts signaling busy on DAT0, hence re-read the
> >>> +              * MMCISTATUS register here, to allow the busy bit to be set.
> >>> +              * Potentially we may even need to poll the register for a
> >>> +              * while, to allow it to be set, but tests indicates that it
> >>> +              * isn't needed.
> >>>                 */
> >>>                if (!host->busy_status &&
> >>>                    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> >>>                    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
> >>>
> >>> -                     /* Clear the busy start IRQ */
> >>> -                     writel(host->variant->busy_detect_mask,
> >>> -                            host->base + MMCICLEAR);
> >> Why not clearing busy start event as soon as possible ? Maybe I am wrong
> >> but as far as I understand,
> >> we shall (always) enter that if condition before the one just above ?
> > Two things feel wrong about by clearing the IRQ here.
> >
> > 1) We have not yet unmasked the busy end IRQ and we don't have a bit
> > in the IRQ mask for the busy *start* IRQ (they are the same). Then we
> > are clearing an IRQ that we have not yet unmasked to receive, which
> > seems odd/wrong to me.
> > 2) Even if we clear it here, we are still receiving the busy start
> > IRQ, as described in my comment above.
>
> Ok, that makes sense ;)
>
> I guess what can be a bit confusing is that we have to unmask busy end
> irq before clearing busy start event.
> To better understand the sequence, purely for cosmetic, I wonder whether
> we shall not move that if condition before the first one where we clear
> the busy start event.

That is definitely a good idea, it should improve the understand of
the code/sequence. Let me re-spin a v3.

[...]

Kind regards
Uffe
