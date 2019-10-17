Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120F7DB607
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441374AbfJQSW6 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 14:22:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41770 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438481AbfJQSW6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 14:22:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id g81so2984443oib.8;
        Thu, 17 Oct 2019 11:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Bk+owFUyFzKLHxVQ9TZGi955m3fUTDdG0rIAOhgZF4=;
        b=t/2+zWJyIVGYFiSuVM5vGDE63Fz5raip/EpAbiht03WczwzGnJ7JVFoWuR1GbhIknz
         rdJHsRAbi3szLECM8X4s0XR5eOgIg/JkaQKzyc8o2n7jtcwGdpXvFf4Jt9PmQo3egxhm
         Rs+jxfrccYfMJyHooHUkYegvBKurSHi6UwFkJoUndna1IH1HU7v7dYCBS+PTcMv6EklT
         6Uq7MURR0sqryfcAnQ/WiIR11zMSuYpxc07zpEy8fV+48/cJq5AA/pqnh7VaWLFBJtGY
         /QGICPpG+QIeb8H6gwPBVxqSJdI8nr2j0plUGjsPDlE5xhBz7Q1TRG4lJ21NEK0m41sY
         7FPA==
X-Gm-Message-State: APjAAAXDnX8GhcHpiiWqmReUp5PRgLwCqD+lIYO59GTfUnhuuPhUEVB7
        L95zk8WAW1X+shmpOADCvw==
X-Google-Smtp-Source: APXvYqxoyB6LIwYRwOT7YZvltCww+hzSZ2xpYH5QFe7x2JQodAk8yt9q3uBJpfEDLYt0WE9APEi6/A==
X-Received: by 2002:aca:110b:: with SMTP id 11mr4377794oir.135.1571336577100;
        Thu, 17 Oct 2019 11:22:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm686623oin.26.2019.10.17.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:56 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:22:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, mdf@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Message-ID: <20191017182255.GA7053@bogus>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
 <1571293310-92563-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571293310-92563-5-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 17, 2019 at 11:51:46AM +0530, Manish Narani wrote:
> Add optional propeties for Arasan SDHCI which are used to set clk delays

properties

> for different speed modes in the controller.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index b51e40b2e0c5..e0369dd7fb18 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -46,6 +46,21 @@ Optional Properties:
>      properly. Test mode can be used to force the controller to function.
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
> +  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
> +  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
> +  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
> +  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
> +  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
> +  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
> +  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
> +  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
> +  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
> +  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
> +  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.

Should be common?

Range of values?

> +
> +  Above mentioned are the clock (phase) delays which are to be configured in the
> +  controller while switching to particular speed mode. If not specified, driver
> +  will configure the default value defined for particular mode in it.
>  
>  Example:
>  	sdhci@e0100000 {
> -- 
> 2.17.1
> 
