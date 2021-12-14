Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21103474351
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Dec 2021 14:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhLNNVN (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 14 Dec 2021 08:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhLNNVN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Dec 2021 08:21:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB5C061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 05:21:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u22so28236181lju.7
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9Wl5lITTts8KnryH+o6/rjfKY83qkpib99rnG6MLKU=;
        b=bwceb9iKmYVq/D+jBiFE3KXrNwiPRMQzWXwF3DPLI2Cps7rZlOfLcgmBc+W+42pqkF
         8Bf6F7ojcsAQ4nKKUw0zriAvgNrs2vVt1YTo8F9JbC2qidPIhYCXlT2h2pC2gqsm6yrg
         MV2FCr4hBidsRw+8dCkw85U7vYvO+m0apaiudFlcMGTdlSKo/jeHtQg1pqsRi3dhbEHa
         5YGo+ceVI+zoFCTyYfMlDElus2IpanFsbK5g289TcdphgVtkXIXtiWoa7aKY8vMCzUFV
         y/l7L2IcUNTHlht25MaL0TEWFlDXoG+IzAHhqHIfgQ9GPvhM6m7X7YDhvEynOQZfCaxT
         FXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9Wl5lITTts8KnryH+o6/rjfKY83qkpib99rnG6MLKU=;
        b=wjSL7Zpd589/qTuSv6vz/qOOTaNR8nRD0gxA7wUE4IVmlMsVjCTuRQBLrDFv0mCUdt
         GIyVvmuQ5FgPsU/jzqn8lTAnYoM9JW3+O5Oh3ajO5hdfqyqEsnXnb5R4AjqV0BqoSEx3
         gne+kGLPwuQDEZsfFKNPgE+r+pJO5Ig6BbaVpLqDc4ZQxQLBOBr2zrS0QjO7YEqHco3G
         oa34/fUZqw0sjUYhmv24wfVvMKK5ZrEezQULupvQNTa5Dh0CtTE9OMdg9QhURkJWljkJ
         aAPafNpFdneQWRr/0XSnRj81/pc75/XwTVoNgyLrVV2E16VmIj4sMaBdB9VzKfm2gOsU
         8ujQ==
X-Gm-Message-State: AOAM531f/IahWYG0s0o0UwZ59SQQBktiOtcSSh+KfJmghpR2rfFSXxZl
        rWcNvWdTdpDMWobvqkWtR3GjktttBIq2iVE2oQJUmb1W66Q=
X-Google-Smtp-Source: ABdhPJwhGEndahGW68SqTRlSvysT3YExx60q46MfQeoplF9RHvnSnojc8WHIF0sOtUQk2EbReAF7vuu+x2t31V3fF80=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr5018537ljm.16.1639488070994;
 Tue, 14 Dec 2021 05:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com> <20211212145956.1423755-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211212145956.1423755-2-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Dec 2021 14:20:34 +0100
Message-ID: <CAPDyKFq4Q2M=MimXAERtBy+UY79NwLQs8afGWvvXatOrP_LB7w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: meson-mx-sdhc: Set MANUAL_STOP for
 multi-block SDIO commands
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Dec 2021 at 16:00, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The vendor driver implements special handling for multi-block
> SD_IO_RW_DIRECT and SD_IO_RW_EXTENDED commands. It sets the MANUAL_STOP
> bit in the MESON_SDHC_MISC register for these commands. In All other
> cases this bit is cleared.
>
> This fixes SDIO wifi using the brcmfmac driver which reported the
> following error without this change on a Netxeon S82 board using a
> Meson8 (S802) SoC:
>   brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
>                           BCM43362/1
>   brcmf_sdiod_ramrw: membytes transfer failed
>   brcmf_sdio_download_code_file: error -110 on writing 219557 membytes
>                                  at 0x00000000
>   brcmf_sdio_download_firmware: dongle image file download failed
>
> And with this change:
>   brcmf_fw_alloc_request: using brcm/brcmfmac43362-sdio for chip
>                           BCM43362/1
>   brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may
>                             have limited channels available
>   brcmf_c_preinit_dcmds: Firmware: BCM43362/1 wl0: Apr 22 2013 14:50:00
>                          version 5.90.195.89.6 FWID 01-b30a427d
>
> Fixes: e4bf1b0970ef96 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index 7cd9c0ec2fcf..a89190d479cf 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -135,6 +135,7 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
>                                     struct mmc_command *cmd)
>  {
>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> +       bool manual_stop = false;
>         u32 ictl, send;
>         int pack_len;
>
> @@ -172,12 +173,20 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
>                 else
>                         /* software flush: */
>                         ictl |= MESON_SDHC_ICTL_DATA_XFER_OK;
> +

Maybe add a comment to explain a bit about this workaround here?

> +               manual_stop = cmd->data->blocks > 1 &&
> +                             (cmd->opcode == SD_IO_RW_DIRECT ||

SD_IO_RW_DIRECT doesn't have cmd->data, so checking for that command
doesn't make sense.

> +                              cmd->opcode == SD_IO_RW_EXTENDED);
>         } else {
>                 pack_len = 0;
>
>                 ictl |= MESON_SDHC_ICTL_RESP_OK;
>         }
>
> +       regmap_update_bits(host->regmap, MESON_SDHC_MISC,
> +                          MESON_SDHC_MISC_MANUAL_STOP,
> +                          manual_stop ? MESON_SDHC_MISC_MANUAL_STOP : 0);
> +
>         if (cmd->opcode == MMC_STOP_TRANSMISSION)
>                 send |= MESON_SDHC_SEND_DATA_STOP;
>
> --
> 2.34.1
>

Kind regards
Uffe
