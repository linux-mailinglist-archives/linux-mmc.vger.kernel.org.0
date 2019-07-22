Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A137016C
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfGVNnq (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 09:43:46 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35924 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730575AbfGVNnq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 09:43:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so26093503vsc.3
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGmqG4ptpoLIjXtcAYy8btzZvJKDKHMEImKjNaUWrIw=;
        b=cXznW2faB3D/zdq8swGVmyFl8k+9mAGF+PgWbMSfNGiTYAg646sq3YBoAbRbi9gTv7
         1MjSWnUxAD3qZGkTFy9ERBAOA1/OqdzaDngC73lRQRVFjw4yANKrr7ksdw68RfR2u3f1
         k4Xx6OL6BAVjai3eJBIl0Phg3dUszMgfYzZJDqkr63ZcUzA9t17Bgw31+mCMCgN86FPN
         T7zxWbbDUhAg+mfGUFjJLvlGSU4eq33rw4UCFosTKHZZ/R/E7HwhdeTrxcOZxHFoQWQ/
         vdmvtJgN6mHpn7QEtxBHfwSrysZTZClVtNYUvxqiTQuGIrxQt6Y8vsReWrs8Ow8AWgR8
         z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGmqG4ptpoLIjXtcAYy8btzZvJKDKHMEImKjNaUWrIw=;
        b=Z9FHf4/0zYV3YwYBTThhSpvalXgFsXSYZN0DknrBYzKYCs+nypmtZuB6IMFa9bXgKe
         0TEJh/WuHFJRUMNDA5F7uTmt7SbuAEkNYlkB7RVJy/a4YET8P5h4Df3+tZDyG2esx4QP
         11PnA/k+Gbi1yW2rIFSTF1Rp5Lgd5RUC/TkGRrQpxAdDfvs+h9Mt9AYVEYVHRwOhvhuE
         J6t+8cYEs7TxzFYxKTZQH2An+u1TasYWMe9c7BBpSGQW577xbr6PSat3/u9oIuCpG8RZ
         CHtyBHGWBB2cHoBm04xSyUS0BFsAV47UM/6os8s3OGaWgUnCcR6ueNQqP1PHvwZ5rj41
         39tQ==
X-Gm-Message-State: APjAAAV0uyCA3VuruRwIugRzkVdRXP/pUq3I3qdo9HfZXGrGESTW5YZN
        QKYzCVhm4tYQXZet4jq+kFs8cczvSMTt5RwX0rAVdw==
X-Google-Smtp-Source: APXvYqzkfGZ1DKRRQAo+4IRI8owf3oXR3DF9EBGvHNO5tTE1l1JMNbpTfmAk+9D6uiCqKpvCr7b42xz1Nh+0fNXXddQ=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr41692590vsp.191.1563803025344;
 Mon, 22 Jul 2019 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190717085259.31235-1-Anson.Huang@nxp.com>
In-Reply-To: <20190717085259.31235-1-Anson.Huang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:43:09 +0200
Message-ID: <CAPDyKFqfhk6S0gN-eN5ozYKZPBWb8+gC2A_vy55gYOx7dOKQ-w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 17 Jul 2019 at 11:02, <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index b334e81..78e7e35 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -571,7 +571,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         struct mxs_mmc_host *host;
>         struct mmc_host *mmc;
> -       struct resource *iores;
>         int ret = 0, irq_err;
>         struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
> @@ -587,8 +586,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host = mmc_priv(mmc);
>         ssp = &host->ssp;
>         ssp->dev = &pdev->dev;
> -       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ssp->base = devm_ioremap_resource(&pdev->dev, iores);
> +       ssp->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ssp->base)) {
>                 ret = PTR_ERR(ssp->base);
>                 goto out_mmc_free;
> --
> 2.7.4
>
