Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4E7D949B
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Oct 2023 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjJ0KDM (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Oct 2023 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KDL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Oct 2023 06:03:11 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E05191
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 03:03:08 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5afa5dbc378so4380447b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Oct 2023 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698400987; x=1699005787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YXE7lgarxwuv4Xl7UQk0cudPQAILR43rhjN5/cXQAig=;
        b=qlMKTcoMuz2ascR0kUAJFi8oBCTlpoi3kS1ibXH0Nmy/tbs1bgkQvLSGIaQcD5BWOQ
         Ub9MWQZYofB+qZdC7F+5+raVfyHzlcxcNk0+QIxokLaxiAZ/RBodjT14k70UgrthLiD3
         ZqFHeGCmIQD7RBceA+A+aeH534GwNdGTMBf/3il1aI7RJk269zH5o6pTgJtHBuCllY3v
         46AI6oa07c5F0LGiif2aJ3jyXlIxT5+Jhq6gPy6EQaZEgkNbF/dYPJJrnFwIY1/CYhsw
         /cnyJZlAAUevS1LrSqLTuyh/w5yAuLTlb5LxVFDm9YuNyd11TWvn/i4Gu6JkkgyDpD7i
         Hzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698400987; x=1699005787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXE7lgarxwuv4Xl7UQk0cudPQAILR43rhjN5/cXQAig=;
        b=Z/kz8QCB2tNce2taeMHxgrWZ4BuwRVfiefoOaya/RTxoBTKf0GRHkGvgtkDbhY35ej
         1uT5G3vHZ+M9wFPTOfNRi8vnCy+NQoVMYSBxdM1LMok8MAPo54FdsBlUYDjjXzn/yfDy
         9UAXwBWYkrW80JosFomt7i9aXTIOFzA4Jc44aGZ9wTapSWx8Qx+6sK+IoT6/Rg0AlDd7
         PL5Xza1kpjf3flJHg+4uALc+rnDLC3eE0N8Yi7tHqYp095gy382xbvFapPavmGNxtNy5
         vUVRMGXud5CJVg1NCWoo8oxdcTsRZ/FVDfC61NffV4oPaM29lK1wmnGyB+a6xYU2suCG
         aG+w==
X-Gm-Message-State: AOJu0Ywjl9Jz4uqCOHNprAp4+Cp8JWS36dj8m1Ji+5a1p7L9A8/0dWos
        8CkMFVAsEqGRBizxLuWhhxulYa6aElK6DLSzsGqo1A==
X-Google-Smtp-Source: AGHT+IFYbP/Q1oQDF4bp5AJQ1qmGH7ABvag64Mb4Rq9m8K4E0PNVBVrXn6fERnyi6wwBkU+O2mWw4VNUzTnB2t4ERAQ=
X-Received: by 2002:a81:c80a:0:b0:5a8:5824:b953 with SMTP id
 n10-20020a81c80a000000b005a85824b953mr2187884ywi.8.1698400987537; Fri, 27 Oct
 2023 03:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231026073156.2868310-1-rong.chen@amlogic.com>
In-Reply-To: <20231026073156.2868310-1-rong.chen@amlogic.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Oct 2023 12:02:31 +0200
Message-ID: <CAPDyKFr_NkZYEHN-9BPTQT1K9nMA30_vyry-6pz+G_iAw4uB0g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
To:     "Rong.Chen" <rong.chen@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Oct 2023 at 09:32, Rong.Chen <rong.chen@amlogic.com> wrote:
>
> From: Rong Chen <rong.chen@amlogic.com>
>
> For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
> Starting from SoC family C3, setting this bit without SG LINK data
> address will cause the controller to generate an IRQ and stop working.
>
> To fix it, don't set the bit CMD_CFG_ERROR anymore.
>
> Fixes: 18f92bc02f17 ("mmc: meson-gx: make sure the descriptor is stopped on errors")
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 9837dab096e6..c7c067b9415a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>
>         cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>         cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
> -       cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
>
>         meson_mmc_set_response_bits(cmd, &cmd_cfg);
>
> --
> 2.42.0
>
