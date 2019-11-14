Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D80FC699
	for <lists+linux-mmc@lfdr.de>; Thu, 14 Nov 2019 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKNMyB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 14 Nov 2019 07:54:01 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36724 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfKNMyB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2019 07:54:01 -0500
Received: by mail-vk1-f194.google.com with SMTP id d10so1443246vke.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2019 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7kaYv+E/e8ORn2Gy+9BvMNe/wGdZZ8Ltu87P0bR2PM=;
        b=jmdHDXBhhLyio2z3d9cvr0uOQLVHLSVGA2z0qYJ0zIbiAo2MFl8MKHWVLkO6Q1QBjI
         nEgVba6NRuH2arLCk89WtqyD60ns5PQ/ABDOj29hb9Ldw3HqqjxABeeBov79x0lCy3A3
         1dKSzwQ+rrK15q38Y4AZJkv1wJeEQQE/wyh055dPZMKFzbRoQEQqjSOOXd4jR6kS1ZVb
         WrwOQFRQDHK1xcO6unINH3oMoi8ffSUFg4rvPzydLnGNliXQw3cUglJv22pXKzItg+hp
         KhRV8uCAZVvYZNpVo6wgwcLJ8QMOvFZ967e8VrI1A7x3UCYcCbA9hboWp+nvxDWRF4UR
         FnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7kaYv+E/e8ORn2Gy+9BvMNe/wGdZZ8Ltu87P0bR2PM=;
        b=IXpy+vlRtAW+GrJaf9tADzKVPzZINRig6X9VSUgfeHAQPcXNbG/J0AxhobRfRz/pj2
         gUxmakB8kVFqEb2MJLiVbNkRNPhoTfVx5akRfHk6qSjHTO1kEdoLjpeIiXjahMV9jvvY
         MqaKiFgXkABvmPCcRA7ZXksfE+RQMRKKrQQBTzNG4xcpwm8PZmRJ2Zo+CIThtHCjhAN4
         FhX3UHXLBX2KUCuxuMuaHoi2AvLj+xFUjdWnTZsCJyhl+fbtolPGTjxvvJsjl6Ibxfrn
         GCGWgcEaNy1W7GMKGt3KOCaYvIHl2RC3WjMY1J1PXQjbMs7pRauttdhin3ZM98yWNUN7
         ytMA==
X-Gm-Message-State: APjAAAXgVjYHsA2+SIBV2opji0s8HaK3r1x2hOihP3bfd0PKIlUMlB5x
        CIaySJYfM449bHtA1E5VCSbu8dsySCCne4kIhwhgjQ==
X-Google-Smtp-Source: APXvYqyqmcQFAkEm9m1Jnd6vFouVrLC+OhhaXGWaFFzu1LdB9oTyBPhsXXff0IBdvNsBO1U1ZdQHtW10o/YdvuxHcPw=
X-Received: by 2002:a1f:ee0f:: with SMTP id m15mr5092437vkh.43.1573736039900;
 Thu, 14 Nov 2019 04:53:59 -0800 (PST)
MIME-Version: 1.0
References: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 13:53:23 +0100
Message-ID: <CAPDyKFoL7oJ+2hvi77N9=1hBKFgCXRUppcte1u=eF4z+Fz8TQw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 5 Nov 2019 at 11:23, Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add imx8mq/m/n compatible string
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> V1:
>  imx8mq/m/n.dtsi already use this compatible string,
>  but not listed in binding doc, so add it.
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index f707b8bee304..2fb466ca2a9d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -18,6 +18,9 @@ Required properties:
>                "fsl,imx6ull-usdhc"
>                "fsl,imx7d-usdhc"
>                "fsl,imx7ulp-usdhc"
> +              "fsl,imx8mq-usdhc"
> +              "fsl,imx8mm-usdhc"
> +              "fsl,imx8mn-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.16.4
>
