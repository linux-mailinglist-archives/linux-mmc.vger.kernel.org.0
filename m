Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBD620E8AD
	for <lists+linux-mmc@lfdr.de>; Tue, 30 Jun 2020 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgF2WYi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Jun 2020 18:24:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:32843 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgF2WYh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2020 18:24:37 -0400
Received: by mail-il1-f196.google.com with SMTP id a11so7678321ilk.0;
        Mon, 29 Jun 2020 15:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6PTCG77HwaM0ih3jeDOc3HP4Iu6SbnJJa5V6mxxYTuU=;
        b=XdpeUqm031ZBkcdqSojnvjti2ahjUYFYlGewCekPqwWoxXm1pfumbspkhDomn+dlAf
         IAOFATeJd18z/YKBM15lRxOTZErnv/8SrhGQ8zWbkMETgbAeNDji6zzuQUbalxihlF/E
         VHjvckZAVFHLa8VEe+ex0PswOR110EqkMurp5BaRQI4XwBfsoq/opCk+atYIgGb19Nfy
         pGEm3fHNQkY3+C4qO5M03CbHoNo44BXq+PuYD11IfY1l5Kyz/p1vZxr0Ze4gxAxBf6js
         F/iOxyrtHFwRCaF/0/l/OXLkbt/BuK5GqlGnWy08CQJTRH5ikwYZdQh6OIFguWy3LVTS
         YFCg==
X-Gm-Message-State: AOAM531XLQKx3othU4V8yLpsPmdB0MpFn3oY2DazXQz73ioPL4ffGRtR
        YG0FLkZLYfYRGiy5gFMvtg==
X-Google-Smtp-Source: ABdhPJzX+z15yPd4/F4USUQCOy0AS2gx0hm6uKZ9hLuY9UXtDmEf/fcJ9bRvRoDJxtLgTRjHJDI0mg==
X-Received: by 2002:a92:8411:: with SMTP id l17mr19042053ild.83.1593469476322;
        Mon, 29 Jun 2020 15:24:36 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id a1sm628190ilq.50.2020.06.29.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 15:24:35 -0700 (PDT)
Received: (nullmailer pid 3065852 invoked by uid 1000);
        Mon, 29 Jun 2020 22:24:32 -0000
Date:   Mon, 29 Jun 2020 16:24:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ulf.hansson@linaro.org, s.trumtrar@pengutronix.de,
        shawnguo@kernel.org, sboyd@kernel.org, festevam@gmail.com,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        mturquette@baylibre.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: Convert imx esdhc to json-schema
Message-ID: <20200629222432.GA3065598@bogus>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 11:22:56 +0800, Anson Huang wrote:
> Convert the i.MX ESDHC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 124 +++++++++++++++++++++
>  2 files changed, 124 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> 

Applied, thanks!
