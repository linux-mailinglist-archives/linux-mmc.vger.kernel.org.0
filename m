Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9F6FB12E
	for <lists+linux-mmc@lfdr.de>; Wed, 13 Nov 2019 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfKMNRB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 13 Nov 2019 08:17:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36804 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKMNQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2019 08:16:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id f7so1785978edq.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Nov 2019 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c1UUp/IQwQ/GqNgyB122Ecd+0eqo2Vy84znaErNh4Ps=;
        b=OHY8+vdy6LPz7tt+SJ2O3uTrT6kXlLK/mcVQsCWrKSElqSrRt3TE91AyoZAISFs+CS
         ndIthaxO/cgePTRFm5oBv2EmwNGEzs6YW0201jGGMampghQRTtAPmh/hpoXgyW9bGPiW
         QbqylJ5p0TZoCYdHxDtzuI6xLLXZ01mXQse0QWtlSBdA5IF8DqX1LBPSwMEBJhhqARG1
         Z7cgQv/mdsDqaQvTvN7+GLsb7kgb2A72+9hTDH+J24C3LVMTovOoWgWL43JRMjVuOP0b
         5WC7pfeR7RUJF2nHFsuUgarkmgUhyFVizdRIT7WSb/qtRuRNPta2b4Mj1wGRptS+cP/c
         kq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c1UUp/IQwQ/GqNgyB122Ecd+0eqo2Vy84znaErNh4Ps=;
        b=KLxiPqHnGHkSrEMF3w4raP4FHwVepZ06OUP1QntPwTPkg3iNb0uJ09rcauPEcNxyw+
         t4bqQsaQKl4yTso0WaqAoSgxXZMzhJkkhcRMAlEKKxdQfogJTmEYIFoJjhHa/sHMRwTt
         GlITh+UMqU3W7RiBsrJyjlMREAVZqPjaAEoKuN9+a3cgbRBAkI5aMbMVaNdBLcJPaJDv
         eLNPWKvWF9+aanrcC3edEtP9tug1BBtQczDNMDIhwU90ohhY3sUV21HK1uSGI3Qa+U7l
         /wJztGi5c793nQhEnUWpWLt6qzggpxOALSdqya7yuOeH3MjC2a7udCuNGJaah9ulH9Xg
         LzlA==
X-Gm-Message-State: APjAAAWwAUTyl3k/W//rQkZRQTZ6imz/m5TlGANWkdLNjv8QpZj52IGC
        0np6ywZ/yculZHwYMaJGGesXHg==
X-Google-Smtp-Source: APXvYqzyibJzdZnPnNzsFGuMFvtTc170qd7sUq9kQhVCuW92HMHYNY0fkpxleroMHQhDXoMyxTbhYg==
X-Received: by 2002:a50:a2e5:: with SMTP id 92mr3495258edm.195.1573651014588;
        Wed, 13 Nov 2019 05:16:54 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id t4sm242385edj.53.2019.11.13.05.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:16:53 -0800 (PST)
Subject: Re: [RFC-v2 1/2] dt-bindings: mmc: sdhci-msm: Add Bus BW vote
 supported strings
To:     Pradeep P V K <ppvk@codeaurora.org>, adrian.hunter@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org, vbadigan@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, sboyd@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-mmc-owner@vger.kernel.org
References: <1573220319-4287-1-git-send-email-ppvk@codeaurora.org>
 <1573220319-4287-2-git-send-email-ppvk@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8d7f2a2f-1312-8983-4e58-80dc6939154c@linaro.org>
Date:   Wed, 13 Nov 2019 15:16:52 +0200
MIME-Version: 1.0
In-Reply-To: <1573220319-4287-2-git-send-email-ppvk@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pradeep,

Thanks for the patch!

On 8.11.19 г. 15:38 ч., Pradeep P V K wrote:
> Add Bus bandwidth voting supported strings for qcom-sdhci controller.
> 
> Signed-off-by: Pradeep P V K <ppvk@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index da4edb1..22fb140 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -39,6 +39,25 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +* Following bus parameters are required for bus bw voting:

"bus bw voting" sounds a bit vague to me. I would say instead:

The following DT properties are required for interconnect bandwidth scaling.

> +- interconnects: Pairs of phandles and interconnect provider specifier
> +		 to denote the edge source and destination ports of
> +		 the interconnect path. Please refer to
> +		 Documentation/devicetree/bindings/interconnect/
> +		 for more details.
> +- interconnect-names: List of interconnect path name strings sorted in the same
> +		order as the interconnects property. Consumers drivers will use
> +		interconnect-names to match interconnect paths with interconnect
> +		specifiers. Please refer to Documentation/devicetree/bindings/
> +		interconnect/ for more details.

Please describe here what there are two paths are for sdhc and how they are
expected to be named. You already responded to this question, so please include
this information here.
Hint: Refer to the Documentation for how we described it for other subsystems.

> +- msm-bus,name: string describing the bus path
> +- msm-bus,num-cases: number of configurations in which sdhc can operate in
> +- msm-bus,num-paths: number of paths to vote for
> +- msm-bus,vectors-KBps: Takes a tuple <ib ab>, <ib ab> (2 tuples for 2
> +				num-paths) The number of these entries *must*
> +				be same as num-cases.

If it has to be in DT, could we use this [1] instead of the above? The patches
are not merged yet, but this might be the direction we want to go.

Thanks,
Georgi

[1] http://lore.kernel.org/r/20190807223111.230846-1-saravanak@google.com

> +
>  Example:
>  
>  	sdhc_1: sdhci@f9824900 {
> @@ -56,6 +75,19 @@ Example:
>  
>  		clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>  		clock-names = "core", "iface";
> +		interconnects = <&qnoc 50 &qnoc 512>,
> +				<&qnoc 1 &qnoc 544>;
> +		interconnect-names = "sdhc-ddr","cpu-sdhc";
> +		msm-bus,name = "sdhc1";
> +		msm-bus,num-cases = <3>;
> +		msm-bus,num-paths = <2>;
> +		msm-bus,vectors-KBps =
> +		/* No Vote */
> +		<0 0>, <0 0>,
> +		/* 50 MB/s */
> +		<130718 200000>, <133320 133320>,
> +		/* 200 MB/s */
> +		<1338562 4096000>, <1338562 4096000>;
>  	};
>  
>  	sdhc_2: sdhci@f98a4900 {
> 
