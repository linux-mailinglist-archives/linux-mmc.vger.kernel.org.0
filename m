Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89565B89C8
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Sep 2022 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiINOCx (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Sep 2022 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiINOCR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2022 10:02:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240C12D23
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f9so24634035lfr.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2022 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CQjeMfDwFntWQm9a05PkWbLPryxYJltoZlwh5tZAobU=;
        b=p/ixekQ7dm+pVuUqal2iNjjPgvi7AVWgQI/uKNZ6DBRcW8zFtM/K4ZQCdLq1nN3NjE
         wCUGP04upvlanW3RG7PcQKWcGH9y3knnoB3dPW5HkHQN+EIcllL+vFL10yQyjX4yX8Lw
         o+N26Fk/JksE42yxl4ZVhBXuz660cSG3bO84GWc/sZDtqLWVwqhOnhPqTKCpxGfxzj96
         cs+ucS5RrIxrJ8PR46tGBac/XbLONdX6grwiNilK/0zn4Mb0AXJPt0TyKkPNKPUHEe1s
         4Ix8khEtmCNRWUwqQR6diomyghIy2d8qO0iUoQqfkAFTiq2Fh0a0GNWYtCuOdNCB30Gr
         GkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CQjeMfDwFntWQm9a05PkWbLPryxYJltoZlwh5tZAobU=;
        b=YwH6bTtCTyiyeVqoxXwmZP4wYCwEwp6N5/SRLouET2KpaHZprEYO81ECsDWEwUy5kU
         qX/pV0g7lf/nBjBLeE783WlVDHBBqOAw771s4jX7OBAVRQjPO8LW/c/Ep3o1bp+A92YO
         UK6BXVoXaRF1soGTbPHZbpRzeE6kW4kWvZhESCooS2l/vUcsAFdiqdePqVISLM2RfL/F
         7A2lYSD0DdyRQj3+S7nA/W2XTFRovNeICnYWHQKjwuHwc7kyYwoI0d3XAv6VP6sZQxHg
         iK4WAyAZQT6yK/FplasxgXTHO32LtLG1cpOPadhVi8C8kAbpbQvEZzhDlAOVMcyUCSAY
         nFLw==
X-Gm-Message-State: ACgBeo0+C1VnsSkpLHdMsMcFhtON6Iv3K4ENU1wOI9YwY4zyiWGJgEqW
        YZVpQ+CcAlXv3zz3HMXiJxFzIdv72UKOOYzjXW98oA==
X-Google-Smtp-Source: AA6agR6WyXBDRFbuI65gA1rXLh/luIbvyPLMNXN5XHAxLKNXhlzA+yGIFDQRTOBeyxgqkUpliZ5dXOpmMTTxMc+MmNc=
X-Received: by 2002:a05:6512:280d:b0:498:fd40:51d4 with SMTP id
 cf13-20020a056512280d00b00498fd4051d4mr9246731lfb.167.1663164091519; Wed, 14
 Sep 2022 07:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220907035847.13783-1-wenchao.chen666@gmail.com>
In-Reply-To: <20220907035847.13783-1-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Sep 2022 16:00:54 +0200
Message-ID: <CAPDyKFpZN7=K2pTS2b0jsDp=uTVjTsQV+27e=rkGs_gMHfb97w@mail.gmail.com>
Subject: Re: [PATCH Vx 5/5] mmc: sdhci: Fix host->cmd is null
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Sept 2022 at 06:00, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> When data crc occurs, the kernel will panic because host->cmd is null.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffe..2511728 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>
>         if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>                 *cmd_error = -EILSEQ;
> -               if (!mmc_op_tuning(host->cmd->opcode))
> +               if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>                         sdhci_err_stats_inc(host, CMD_CRC);
>         } else if (intmask & SDHCI_INT_TIMEOUT) {
>                 *cmd_error = -ETIMEDOUT;
> @@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>
>         if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>                 *data_error = -EILSEQ;
> -               if (!mmc_op_tuning(host->cmd->opcode))
> +               if (!mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))))
>                         sdhci_err_stats_inc(host, DAT_CRC);
>         } else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>                 *data_error = -ETIMEDOUT;
> --
> 2.7.4
>
