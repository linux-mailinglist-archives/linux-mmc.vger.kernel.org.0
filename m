Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121BC60CBE2
	for <lists+linux-mmc@lfdr.de>; Tue, 25 Oct 2022 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJYMcw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 25 Oct 2022 08:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJYMcv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 08:32:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5071843CF
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 05:32:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so11859411pjl.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2022 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZQP1qAhrHf0Cvjfzk+eUhgbgDIxQ6BfTBmSsRN+dFs=;
        b=NPGtQ67Z+kXryLQsa//R2vXLFh65ckQjsK7fw1EQ3NdLzluyWerckFr2bTR7Q2h5mb
         TZ9lhMWxlKRP8j9QG6rtrx82yPY26TRlAc3VtnTfC1neBA+ATyMd5jj8NbGMVyVc7faN
         TxCpCJ8u0dvJUgEwwxeizCzKPfTuTquL8hgQN7/ANLuxcSzz2cv7OiJ+uz5Nh2vJLcfz
         6IecVPU5r4iJwKyStFUzakxplI0uQGTJxWoJJ4xU8sd0Laqq8BAY3TFhz7K8xOPVNIil
         dWkxlZSF83WgSBsPsQZmguyiUsr/ss7Vq83uefHo3NwSqOiAFwbSyDeBoutSBAPN8dvZ
         xJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZQP1qAhrHf0Cvjfzk+eUhgbgDIxQ6BfTBmSsRN+dFs=;
        b=Tv7hohlrPRIPjDCy1q+ETOun1nBnVCDimiuuTYbmROugef8y5DTdORoYscwFB0eh7N
         rnPBGmJ69HaXIdr9cuQwYCfQr7uFQ/Oit5PabjTpDGSD6wz+DSv8eSQqL4WvsoxmBrm8
         V1U+awkyGkXboEDYCpJUyxNa8U3K5pS+TqBxgRTU2ZuOUPF5PQGi/DyVNwBCFJqEtpXE
         ZrhuYPsvGCrU232hQqB6MaGP2RrwYNwCZThZeVi114b6l0vSXQrpNKf6PPzeaI4jhe/S
         KT67BVaeOZUOzzWsVUwBg/PoeeWLPZSkGHEEuqlgXx0vOCOe+J2nJqAElum681/ZfeZ3
         vu+Q==
X-Gm-Message-State: ACrzQf0+GMcAsfj1wdZ8vUZl69fedkwuR42LaGPVDVdnNQcSVBjACEIR
        vmoezz5vT3pNe4htjublBaxd1gcuMRRxTQgeVZ/cwf8QI4RRvg==
X-Google-Smtp-Source: AMsMyM4PNCqlgCAmFoeDQGdn/DBd5DjMD080aocprxHSSN2Qv+4cAzzaKa2pJNys2e5w/lbcqMEYdHNdFNWvad3qapQ=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr37995210plh.37.1666701170325; Tue, 25
 Oct 2022 05:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221006190452.5316-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqA1RtcaGMCQgDsKKju4izHWJRAD12SqqirNm+TWLt_hA@mail.gmail.com> <60c3285a-e1a1-4aac-8c6f-23301f7b05e4@app.fastmail.com>
In-Reply-To: <60c3285a-e1a1-4aac-8c6f-23301f7b05e4@app.fastmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 14:32:13 +0200
Message-ID: <CAPDyKFr1xxKCC+aOPD8vW3oBnMyt5366mXgkcgNugDwWa_R3ew@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] mmc: renesas_sdhi: add support for DMA end irqs
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Oct 2022 at 13:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 25, 2022, at 12:51, Ulf Hansson wrote:
> > Hi Wolfram,
> >
> > On Thu, 6 Oct 2022 at 21:05, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> >>
> >> Motivation for this series from patch 5:
> >>
> >> ===
> >> So far, we have been relying on access_end interrupts only to mark DMA
> >> transfers as done implying that DMA end interrupts have occurred by then
> >> anyhow. On some SoCs under some conditions, this turned out to be not
> >> enough. So, we enable DMA interrupts as well and make sure that both
> >> events, DMA irq and access_end irq, have happened before finishing the
> >> DMA transfer.
> >
> > The tmio/sdhi core still relies on using tasklets. I think we should
> > strive to move away from tasklets for all mmc host drivers and to use
> > threaded irqs instead.
> >
> > That said, I am worried that it might be harder to move away from
> > tasklets beyond $subject series, for tmio/sdhi, but I might be wrong?
> > So, I am wondering if it perhaps would be better to make that
> > modernization/conversion as the first step instead?
>
> Moving away from tasklets is probably a good idea overall, but I'm
> not sure that MMC actually needs a custom IRQ deferral mechanism
> in addition to the existing BLOCK_SOFTIRQ. I would expect that block
> drivers usually operate in the context of the blk_mq caller, and
> adding in another thread context can add substantial latency.

Well, it's not that simple as it depends on what the MMC controller
supports too (and whether the MMC/SD card really conforms to the
specs). We can't poll for busy completions in IRQ context, for
example. And in some cases, we simply need to poll with a CMD13.

Don't get me wrong, I am not promoting a custom deferral mechanism for
MMC, but just a regular threaded IRQ handler (per host driver of
course) when that is needed. And most mmc host drivers already have
that today.

For more sophisticated HWs, we have the mmc hsq interface, that host
drivers can hook into, to potentially avoid some unnecessary context
switchings.

>
>     Arnd

Kind regards
Uffe
