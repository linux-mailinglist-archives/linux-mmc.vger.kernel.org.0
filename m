Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397A378FEBE
	for <lists+linux-mmc@lfdr.de>; Fri,  1 Sep 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjIAOKk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 1 Sep 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIAOKk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Sep 2023 10:10:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F610F0
        for <linux-mmc@vger.kernel.org>; Fri,  1 Sep 2023 07:10:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7b9de8139fso1544260276.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Sep 2023 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693577436; x=1694182236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5ivJRk6mwgIHtFh3KMVKCYCuw+/3Xv2OEnm7TPvNFg=;
        b=foSqnSgUWlWCpmXkN8Elz8ysITTzkptYGTapeSSkSb+3AfEVmndmQqCf32d+KDWpHI
         i9RkLtDUaCv8IAYc8ZqD7573tgFNKBtEq55U+k5Kj66fHSF74LR/rOj9g6KM2ppYaitn
         KfD10vqxGgr9bUeowxh7gQIe/uPvcM0l9+IQQuwV9bNh+LYFzomcGwYwoEDIx/rbYGp5
         VRFYpXh9I0gO1U0tA/ebq7PQ9pDyCHp5KyWGQt5yyERSE8MoyehI/50i8TYFvzUW60jS
         qH6JPGfS2O5GKOITKrvAQEvU72fSjv3k4fWmgAGTDuATH+mjaJgOL6Cga6THEqS2isO/
         UunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693577436; x=1694182236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5ivJRk6mwgIHtFh3KMVKCYCuw+/3Xv2OEnm7TPvNFg=;
        b=MXf57AtSmiMJQbube3n9dXhybqfRG/OuTUi+lALi7rfMRBnmu4ZBeru2RyDjN3rzIx
         q7YOfUbZB1MgdxmLI+s7ihKEvxZM+qzP5mzDSa8Qk+lBo+mLg0gmrYLiEz7ixaF1eKm/
         +CHmFo9gUw4mL61kfqig8yqIYzGBojjkKXT3GHlHBhkFYrGxjDTsNUggjMRm8NVGADic
         jnfiMke2qvLwpnECItxfGUZp2e0HflxcL4xXoUKmQ/lShzhre50AAGT0iqVGja9eG+r6
         kDD/usABYiMvkaPW1cjniuZ8Hg1BxHqUe2cLbiLPC8c6eI2f6WPJHa3KAKxJmnmO0JcK
         nDwg==
X-Gm-Message-State: AOJu0YwSF6ft0R1xEbkppjgCArwYpjoMx6D7QU+abMNLNHVq7gu5CpvM
        GUi8Q/vN1GkiizTRXDtuLVpEj6WB2En+ZhvWCCNO7Q==
X-Google-Smtp-Source: AGHT+IGeX6+J14WR9ieCPyefDidZy7twC0zUDNwqm05Rh5OKw5fhGR/Ho7cwhgB+niUlVC3unnXfoiKzgYTT1vOvBGg=
X-Received: by 2002:a25:258f:0:b0:d7a:edf3:f0a9 with SMTP id
 l137-20020a25258f000000b00d7aedf3f0a9mr2880483ybl.50.1693577435568; Fri, 01
 Sep 2023 07:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com>
In-Reply-To: <20230901120836.1057900-1-yann.gautier@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Sep 2023 16:10:23 +0200
Message-ID: <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yann/Christophe,

thanks for your patch!

On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.c=
om> wrote:

> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Add the support of SDIO in-band interrupt mode for STM32 variant.
> It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
(...)
> +++ b/drivers/mmc/host/mmci.h
> @@ -332,6 +332,7 @@ enum mmci_busy_state {
>   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER re=
gister
>   * @dma_lli: true if variant has dma link list feature.
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> + * @use_sdio_irq: allow SD I/O card to interrupt the host

The documentation tag should be one line up (compare to the members...)

> @@ -376,6 +377,7 @@ struct variant_data {
>         u32                     start_err;
>         u32                     opendrain;
>         u8                      dma_lli:1;
> +       u8                      use_sdio_irq:1;

1. bool use_sdio_irq;

2. supports_sdio_irq is more to the point don't you think?
    Especially since it activates these two callbacks:

> +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
> +       void (*sdio_irq)(struct mmci_host *host, u32 status);

Further: all the Ux500 variants support this (bit 22) as well, so enable th=
ose
too in their vendor data. All I have is out-of-band signaling with an GPIO =
IRQ
on my Broadcom chips but I think it works (maybe Ulf has tested it in the
far past).

Yours,
Linus Walleij
