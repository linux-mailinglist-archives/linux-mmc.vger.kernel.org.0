Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3857DF14
	for <lists+linux-mmc@lfdr.de>; Fri, 22 Jul 2022 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiGVJmk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 22 Jul 2022 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiGVJmT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2022 05:42:19 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE2A1EC65
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2022 02:33:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a13so4606456ljr.11
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jul 2022 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAZZ+zZvrQNIBH53DRQidJGGL3IywgMOgKasOQHqRGI=;
        b=yecc/o33SpG3FJV0705q2XlNAbffHKx037EfzgEpjB95oGMlEEJuMDVgipIXcH1Odo
         AU92urHlfHEwMBzYNq+7xtxxz1QN9jPvCae//JvoifaUHBSbPdpBHgykid7Q2L+RUHy3
         jtI89CCN4iNAY5yY80DO5ykohnJDZa6+wsozZGLxZe7uVUktmW5Cll6O1Rlsl8r7i5yE
         6C7eaioh5drnHTfhAtdR5ic6k23mBXrTM6q1w7Jretkg8HJio2ZiuIL1zmC7ooC+7FAy
         aHme9eVzQJWo4IsJvN7mARluA8ClLB6ITXe1AqMSlMfeZMxkmYyFzBc+t/JX6mpzcpUo
         U8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAZZ+zZvrQNIBH53DRQidJGGL3IywgMOgKasOQHqRGI=;
        b=YlM2GztZXlT2XEgfQm7QXP4NSunRnKRUG0ldtXwLilTrpqjaKua6w3Yn7q9pOG+J5s
         8wsE9ZhS8k2EG3JrW2QvDg+do7UUMAd+UrMltjU104RE6X21RWYOOo5oonMgyW0BfVrw
         KGng2fz7uXXVTY6hYvcDwIB6viCZGhcgQcDsoppJCcTFG9jPd3+XiHPlqKUARLcfpDgd
         2SfDAlUFvrOthbH96p9DZGc7r8vGYgIdqBLy86KrR70kI21AKtjdq707jQeD9mgcAi3a
         tUM6KgDkSBxHFpKkqe6qExvcWwEX9zLFoBEroNMLTAiK9fBgsM68kCMmt5DDxKA4vKAP
         ahOw==
X-Gm-Message-State: AJIora+IvtR3DDQQoVvEmemyCYOhkY6j8oVsaXaYvzSko6uo5O8sVLIo
        aQxBGW/XQxN8tnft+xb5s22UCX8+PWa5UEByJO7/778Y9ZY=
X-Google-Smtp-Source: AGRyM1tuFeL40FXNplF3DiaFKWMK80dA2FT32q0LOAoiBjUTCYptRGrlgOmrTynjE+KfsV1d7HA14nI3swNVUSJTITg=
X-Received: by 2002:a2e:a5c9:0:b0:25d:dc6e:1918 with SMTP id
 n9-20020a2ea5c9000000b0025ddc6e1918mr903972ljp.229.1658482394393; Fri, 22 Jul
 2022 02:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220718082650.9784-1-wangborong@cdjrlc.com>
In-Reply-To: <20220718082650.9784-1-wangborong@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jul 2022 11:32:38 +0200
Message-ID: <CAPDyKFpBc_XZStRb7mwQ_nN-YUnxxmXrqx6hFFxoVG=iJ-VdiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-acpi: Fix comment typo
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Jul 2022 at 18:30, Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The double `the' is duplicated in the comment, remove one.
>

Hi Jason, these spelling fixups are getting somewhat annoying to me,
sorry. Don't get me wrong, it's nice to have good readable comments,
but the patches don't really need to be one line of change per patch.
Could you perhaps look over all mmc host drivers and fix all spelling
mistakes in them and send one patch to cover all of them instead?

Kind regards
Uffe

> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 4cca4c90769b..bddfaba091a9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>          *       in reading a garbage value and using the wrong presets.
>          *
>          *       Since HS400 and HS200 presets must be identical, we could
> -        *       instead use the the SDR104 preset register.
> +        *       instead use the SDR104 preset register.
>          *
>          *    If the above issues are resolved we could remove this quirk for
>          *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
> --
> 2.35.1
>
