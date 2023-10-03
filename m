Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10CF7B65F0
	for <lists+linux-mmc@lfdr.de>; Tue,  3 Oct 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbjJCJ64 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 3 Oct 2023 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbjJCJ64 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Oct 2023 05:58:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D364A3
        for <linux-mmc@vger.kernel.org>; Tue,  3 Oct 2023 02:58:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d81f35511e6so620661276.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Oct 2023 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696327133; x=1696931933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=znrOVYIM3TgYWJ+uG1Asu14WG/jKlSZIDknBX8rEXMs=;
        b=H+OqqOoxj3kvNqMBQgjkn19cJV37rshMzVtStcV0zsXzO1CKLVa/bD8qsabWbipy8f
         13qP6hJK9OIF7lv5yU3ns6PogcNPhwIvYGOowBhUPJGDPNx3Cpy8Es6sn/FCU9bX5Uez
         tDCQXBkYvrq4evI8blKqWR9D8nPU8GFudG3rQXXhPCsPQAdluxv0+72UZIkBzWfw4vyc
         MISX1lDmnDxgjLFUorFsEGqqoWzPoGCEB3bMZud8SA2iVvqF3KY0VCVTSYEyLAKcA40y
         mKYh2+SUZYFHdc9ysj1FUsQ14OPNx+O0PeDmMauprOusvbWn0Y4BrqDINfAz1vWN81bv
         1qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327133; x=1696931933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znrOVYIM3TgYWJ+uG1Asu14WG/jKlSZIDknBX8rEXMs=;
        b=toMSDaFY1BG0YkWIui3HMyLbpJeCGSI5kpGdX/Q5J+/Qfv/PCbrzf3QjEWDxvn48Sz
         fu++BnQRRcW+pKJNAR/5P4tegUP0qktGPW/BNiXNkjOZ+5oRQBtTuOT9MBk6S3k6b41w
         Esumtldb5JClKLDqUE9PSEMzg9fVbKFs+FfXwoSDXIHMC6ZevF1xD5rMKQswrN1WWaCb
         wB7JjO1bL8oRAVYj6LuZ0sUvJsDq8IGOxGbLizOB63MExlYucfwTPz6e1SPMDa6HNFUR
         +yHif0MwiUQ/OP9GZEbccT3DcP82qMVNqB37pHBpmKHuQcx0fSqKXe0Cu3MyN8nctqcz
         X0DQ==
X-Gm-Message-State: AOJu0YzD6vIfufwZjHZdd6zEUH3ionYHSnZ2jk39PTQed/6oijJOeSSk
        k9+6hae4q86f3wD7lomSkv0+Vod8hLCwAfhy1/6JPg==
X-Google-Smtp-Source: AGHT+IHOABImhHJaaAE1q8BneZDvSrnMU/2KbtgnUSN9zby4FOmr+mJVXE7EryPRqvcEvH697Oy130x/J8DeF5Wx7ZU=
X-Received: by 2002:a25:accd:0:b0:d85:ae0d:20eb with SMTP id
 x13-20020a25accd000000b00d85ae0d20ebmr1606305ybd.14.1696327132702; Tue, 03
 Oct 2023 02:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230915094351.11120-1-victorshihgli@gmail.com> <20230915094351.11120-13-victorshihgli@gmail.com>
In-Reply-To: <20230915094351.11120-13-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Oct 2023 11:58:17 +0200
Message-ID: <CAPDyKFpzuds6Ttbhw1cqZwisa+M6167DT3DUihcDqFjYJX95eA@mail.gmail.com>
Subject: Re: [PATCH V12 12/23] mmc: sdhci-uhs2: skip signal_voltage_switch()
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
> so no voltage switch required.

Can you please elaborate on this? I don't get anything of the above, sorry.

>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>
> Updates in V5:
>  - Use sdhci_uhs2_mode() to simplify code in
>    sdhci_uhs2_start_signal_voltage_switch().
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index fc37a34629c2..92fb69b7e209 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -142,6 +142,27 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>         }
>  }
>
> +/*****************************************************************************\
> + *                                                                           *
> + * MMC callbacks                                                             *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
> +                                                 struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       /*
> +        * For UHS2, the signal voltage is supplied by vdd2 which is
> +        * already 1.8v so no voltage switch required.
> +        */
> +       if (sdhci_uhs2_mode(host))
> +               return 0;

This is just wrong. If we are initializing a uhs2 card, we certainly
should call ->start_signal_voltage_switch() callback at all. This is
for UHS-I cards, right?

> +
> +       return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -150,6 +171,9 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
>
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
> +       host->mmc_host_ops.start_signal_voltage_switch =
> +               sdhci_uhs2_start_signal_voltage_switch;
> +
>         return 0;
>  }
>

Kind regards
Uffe
