Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2E20E8B5
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Jun 2020 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgF2WZT (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Jun 2020 18:25:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46521 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgF2WZR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2020 18:25:17 -0400
Received: by mail-io1-f67.google.com with SMTP id a12so18939676ion.13;
        Mon, 29 Jun 2020 15:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0GaZbixLs4tdiexpjmK+wsDoVQ+ulRxV3n7j6s3bMUM=;
        b=SDWG5qGkLfTamB37lLzs1KLfSBXl/JAxfj8ayGHior+Mu5ZFe11/9FmCVZTwezIwhQ
         G+dzg2Ym0IT3DYgt4S6ZTIL/4nVkyCwsVlgU4Xb1tY651txpV60t9PlzzHxh9bzi6HVy
         LGhmVFZjxlkwsGOnXa5q67kIItzz1Z6y8NPl/MPRSuLEdPVB0wy1qCi+MEU8hes4kVCS
         8zQ3wiYNIOwbSP8EhKuxL3IoD9PvZcdxzDGuxCFaVmgi2bqJOn3z+N13HWKxcWRebPN3
         8PiwY/Vq2GRbJh5o479RYpA23Y+JiEWzq5n9aMRqQoMSeVbhUv/NuILGUIOFbYvuFE+d
         jEWw==
X-Gm-Message-State: AOAM532ZOb/Bk8SJXRxMuw/XfTBSYOn/9J+J7bKtFys8EjC5660mzVKK
        DbR8cUHSzyTt7HO+UZRx0w==
X-Google-Smtp-Source: ABdhPJyCa6IC1Q0r9mfL04iJCZkfDwuIr8IDoWfJy5unmGOizFjyiU2kQ1Sv0NOU7j76tBdlpGPy7A==
X-Received: by 2002:a02:cd28:: with SMTP id h8mr8069309jaq.40.1593469516683;
        Mon, 29 Jun 2020 15:25:16 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id x1sm656615ilh.29.2020.06.29.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:25:16 -0700 (PDT)
Received: (nullmailer pid 3067288 invoked by uid 1000);
        Mon, 29 Jun 2020 22:25:13 -0000
Date:   Mon, 29 Jun 2020 16:25:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        Linux-imx@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, s.trumtrar@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] dt-bindings: clock: Correct example in i.MX8QXP
 LPCG binding
Message-ID: <20200629222513.GA3067129@bogus>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
 <1592450578-30140-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592450578-30140-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 11:22:58 +0800, Anson Huang wrote:
> In i.MX8QXP LPCG binding's example, "fsl,imx7d-usdhc" as fallback
> compatible is incorrect, remove it to avoid below build error:
> 
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
> mmc@5b010000: compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml:
> mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch, to fix build error when patch #1 is added.
> ---
>  Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
