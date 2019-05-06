Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD11147DF
	for <lists+linux-mmc@lfdr.de>; Mon,  6 May 2019 11:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEFJwP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 6 May 2019 05:52:15 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44514 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfEFJwP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2019 05:52:15 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so4406718uaa.11
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2019 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sK1AW46uFm51k7mgTa8btpLaGMbzfNDj8ewiwbIYzZk=;
        b=HeRnYqWwxPUpFC+wvfGu3tZiVy2frYO9St/sbs+uJklMjxVucVdmn6QY7a2+duAoK/
         CqMSO5pHO/0IBK3D6Tpy6f0G/HE1XfBgnM34QQ0mL/CnT3ZIDWkGKeuHqmeTpEnI1fUj
         L0UIqDi/D+qQKexFaE5pI/zS76L4gE3ICEmmi6oh0dGwmUiZ7YoG7SbDNHc3hTdqhSB+
         5jZNYuELm8guM30bxvc0vNWiXNkStWGJG+gZtS9e4UDYrXmeMv3vJ+faoezgMsvXua5V
         aywxibcehAlF3e56cgi2jV+BUUePYEXnNM8PS1BWfmacr8nBZ637YpdzLsM9pBN6SQ2i
         cvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sK1AW46uFm51k7mgTa8btpLaGMbzfNDj8ewiwbIYzZk=;
        b=bagKKGjFnp7k2UQ1SEU3QGA48e+5eBKCGFsT5T/pvVJqB7dEToL2kNor+UzPM4NFBb
         MGKXxmvXfts4URTd7Re2KfeXM9TEEbzaZqu0/8S22C9ejyjTLw8NY7ZwsA1Vg2LlapNF
         6syG0jNt75ziNXTvOPsc31ETWY0AuYCdS2RdUAKo6tFinyZwAbheOmVVTsklofKADlVI
         t1dLLgyXqCAR9FwCfmn8na30YTizhqYg/GhCUChy+5oTRxibUilBSGE8CNmld5jIBY65
         qVyI4peyu1tyLKW3FW58Y143ThTDa1kSjc2jGxBC+8/4bG/xFL6ncz1tMQb74N/3Y5Ve
         ORKQ==
X-Gm-Message-State: APjAAAWfgIYqwwySkCahmNifZIQ/h7oaIlNifMwHKhltoR89jZDMu+hh
        DD7i/DvKg9UJ+kAoE1eKlf4cer38XAlH6jTNDn+2iw==
X-Google-Smtp-Source: APXvYqwRjSSrQqdAGdNhhsMUNgKYFkiN8aJTLBYaPDU00ethSrpubRCAgZGaRAPkoFFQeWvQTDbGYAQff6V2hFR7nzc=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr12246383uar.15.1557136333748;
 Mon, 06 May 2019 02:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190505055858.37509-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190505055858.37509-1-yinbo.zhu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:37 +0200
Message-ID: <CAPDyKFrcFo_zCy5q2VkUP+SxOTogmAsys-X_yBrARLE1dTcqqw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: add DT bindings for ls1028a eSDHC
 host controller
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 5 May 2019 at 07:57, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
>
> Add "fsl,ls1028a-esdhc" bindings for ls1028a eSDHC host controller
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in v2:
>                 as alphabetical order to update dt-bindings
>                 update the commit information.
>
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 99c5cf8507e8..edb8cadb9541 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -17,6 +17,7 @@ Required properties:
>         "fsl,t4240-esdhc"
>      Possible compatibles for ARM:
>         "fsl,ls1012a-esdhc"
> +       "fsl,ls1028a-esdhc"
>         "fsl,ls1088a-esdhc"
>         "fsl,ls1043a-esdhc"
>         "fsl,ls1046a-esdhc"
> --
> 2.17.1
>
