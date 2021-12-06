Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9946A8C1
	for <lists+linux-mmc@lfdr.de>; Mon,  6 Dec 2021 21:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbhLFUro (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 Dec 2021 15:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239954AbhLFUro (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2021 15:47:44 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC7C0613F8
        for <linux-mmc@vger.kernel.org>; Mon,  6 Dec 2021 12:44:15 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 7so23636358oip.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Dec 2021 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Kd/VW0k24ZiHeQ745g+bN45hbG/acmtRc9TNwBDa86g=;
        b=buSDdWYwB4NAhrdftCBmPm5r+hmeyl+5sNoYCON9535QpKwENQ3W6DGlahDKYsvbk0
         UfASPUJHNi4MPAUQwE72yTiJTkf4HQ9UnIRo61L83Qa27ACTh8j0hrzlZM4uwu/RgRL4
         FwW2xz19d5eRj55VHKpMOrwAg26R4WeepTS94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Kd/VW0k24ZiHeQ745g+bN45hbG/acmtRc9TNwBDa86g=;
        b=vX4jSvZfmtF7VQwVZDAQDUyNu+RBLFIWVlNdwlg3TjIjfPYQ8upU9iNRDDFsmPcY/y
         QU9+hjjs1q/VL5YGqHkcPuKsfJWWxEtnMaDiDA5f0yiBOArfvGNQhiXTn1WNm/mPPo05
         RDfyzLBT87XQbHIHJmfoe1Q+XJ+WAiS4uVlRqpFCDyHQ0OVoBP0P+51sebg84clD1YAr
         ME8lu0cCW+akhR+Mi+unnokOO4vzuBPNeqsXAA3M26pA2Sdf7rdGOsGHAK28vsUM2Wpm
         J4WA9oCQ0WZuCZ0tjYszCYS6jIjWS/clDkOvQnzDKStwylckjth3iX721/Tftqe9MyLE
         255w==
X-Gm-Message-State: AOAM531q2IkmCSIyV71vpeiMnH+7l79CH9dE2ITi9yh8SYMYzxXlzqgu
        PlFFZG9bJiHRQlAJLvuduCYkFdzT1JOc6pgKgBriBQ==
X-Google-Smtp-Source: ABdhPJy1aPu4PZyyqqf9TaHxIlYtZXNcCxpyocIp3nHBma+pzCidUmdUcGRG4ZTRJNottzSjYp80KeFFzHWJjk3tVXQ=
X-Received: by 2002:aca:2319:: with SMTP id e25mr1037302oie.164.1638823454543;
 Mon, 06 Dec 2021 12:44:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Dec 2021 12:44:14 -0800
MIME-Version: 1.0
In-Reply-To: <20211205191009.32454-1-nishadkamdar@gmail.com>
References: <20211205191009.32454-1-nishadkamdar@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 6 Dec 2021 12:44:14 -0800
Message-ID: <CAE-0n515qDr95A5PgbhpYer+UT053VzbaDKrxe6zjVgAQwpcEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add support for the eMMC RTC feature in mmc_ops
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Huijin Park <huijin.park@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yue Hu <huyue2@yulong.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Quoting Nishad Kamdar (2021-12-05 11:10:08)
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d63d1c735335..490372341b3b 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1063,3 +1063,62 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mmc_sanitize);
> +
> +int mmc_set_time(struct mmc_card *card, struct mmc_host *host,
> +                u8 rtc_info_type, u64 seconds)
> +{
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
> +       struct scatterlist sg;
> +       int err = 0;
> +       u8 *data_buf;
> +
> +       data_buf = kzalloc(512, GFP_KERNEL);

Use some #define for 512 because it's used three times in here?

> +       if (!data_buf)
> +               return -ENOMEM;
> +
> +       if (rtc_info_type == 0x01 || rtc_info_type == 0x02 ||
> +           rtc_info_type == 0x03) {
> +               data_buf[0] = 0x01;
> +               data_buf[1] = rtc_info_type;
> +               memcpy(&data_buf[2], &seconds, sizeof(u64));

Use sizeof(seconds) instead?

> +       } else {
> +               pr_err("%s: invalid rtc_info_type %d\n",
> +                      mmc_hostname(host), rtc_info_type);
> +               kfree(data_buf);
> +               return -EINVAL;
> +       }
> +
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +
> +       cmd.opcode = MMC_SET_TIME;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       data.blksz = 512;
> +       data.blocks = 1;
> +       data.flags = MMC_DATA_WRITE;
> +       data.sg = &sg;
> +       data.sg_len = 1;
> +       sg_init_one(&sg, data_buf, 512);
> +
> +       mmc_set_data_timeout(&data, card);
> +
> +       mmc_wait_for_req(host, &mrq);
> +
> +       if (cmd.error) {
> +               err = cmd.error;
> +               goto out;
> +       }
> +
> +       if (data.error) {
> +               err = data.error;
> +               goto out;
> +       }

Why not

	if (cmd.error) {
		err = cmd.error;
	} else if (data.error) {
		err = data.error;
	} else {
		err = 0;
	}

> +out:

And then drop out: and the assignment of err to 0 up above?


> +       kfree(data_buf);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mmc_set_time);
