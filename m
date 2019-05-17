Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C421A3B
	for <lists+linux-mmc@lfdr.de>; Fri, 17 May 2019 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfEQPCH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 May 2019 11:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfEQPCH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 May 2019 11:02:07 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2161221773;
        Fri, 17 May 2019 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558105326;
        bh=F2xzjbmPebq5VH3JMx7EEVAsi4CNpDivddgn/1jbBAs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XdxBsIykMyAOabldCz0HuF+LJmO2C5zsJ2+NoTQzHgPcLnVcN9LT7h2Vs4qtynT9k
         e4urQBoDCEMASdSI0DbYvveILygSgBFQbSb6ehyGgbCD8bltJ923MStVW5SfQ285F6
         73YYvqSHjccVh/gm/xsZugZbMVy2kPhNAR+z+3pE=
Received: by mail-qk1-f173.google.com with SMTP id j20so4649577qke.1;
        Fri, 17 May 2019 08:02:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWszdF/J/fGFw96rbeAgTqrr9eY7TuyI1g2iadCFhk1aJhlb9cO
        hzTshMn/x0IMm22ZHuogGoWNhKAxs2fd3gGWiA==
X-Google-Smtp-Source: APXvYqxJ4ypnBJ3cGt4vROxwCij49/tt947ZHeY9PErfDKK8wU2HrMDkPhuoMSAUYqKiKLM0ASN0u5gpEYnHgxklVDA=
X-Received: by 2002:a37:a8d7:: with SMTP id r206mr32659301qke.264.1558105325399;
 Fri, 17 May 2019 08:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <225e90a94e9558db9f72f64aca05b0951b88c7c5.1558017853.git-series.maxime.ripard@bootlin.com>
 <5e126d3a9be35a288863189854ea3828f7e5ad14.1558017853.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <5e126d3a9be35a288863189854ea3828f7e5ad14.1558017853.git-series.maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 May 2019 10:01:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOKBhfu3D=pN4ZOzouAGVL_T=W0hE+LudEOGxJXTBhUQ@mail.gmail.com>
Message-ID: <CAL_JsqLOKBhfu3D=pN4ZOzouAGVL_T=W0hE+LudEOGxJXTBhUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: sun4i: Add YAML schemas
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 16, 2019 at 9:44 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt                | 52 +--------------------------------------
>  2 files changed, 98 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt

Reviewed-by: Rob Herring <robh@kernel.org>

> +# FIXME: We should set it, but it would report all the generic
> +# properties as additional properties.
> +# additionalProperties: false

BTW, I expect this issue will be fixed with the new
unevaluatedProperties in draft8.

Rob
